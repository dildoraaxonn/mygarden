import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/weather_models.dart';
import '../data/weather_repository.dart';

class WeatherState extends Equatable {
  const WeatherState({
    required this.city,
    this.forecast,
    this.loading = false,
    this.failed = false,
  });

  final City city;
  final Forecast? forecast;
  final bool loading;

  /// The last refresh failed (e.g. no internet). [forecast] may still hold
  /// an older saved forecast.
  final bool failed;

  WeatherState copyWith({
    City? city,
    Forecast? forecast,
    bool clearForecast = false,
    bool? loading,
    bool? failed,
  }) {
    return WeatherState(
      city: city ?? this.city,
      forecast: clearForecast ? null : forecast ?? this.forecast,
      loading: loading ?? this.loading,
      failed: failed ?? this.failed,
    );
  }

  @override
  List<Object?> get props => [city, forecast, loading, failed];
}

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit(this._repository)
    : super(
        WeatherState(
          city: _repository.city,
          forecast: _repository.cached(_repository.city),
        ),
      );

  final WeatherRepository _repository;

  static const _maxAge = Duration(hours: 1);

  /// Downloads a new forecast unless the saved one is fresh.
  Future<void> refresh({bool force = false}) async {
    final forecast = state.forecast;
    final fresh =
        forecast != null &&
        DateTime.now().difference(forecast.fetchedAt) < _maxAge;
    if ((fresh && !force) || state.loading) return;

    emit(state.copyWith(loading: true));
    try {
      final city = state.city;
      final result = await _repository.fetch(city);
      if (city == state.city) {
        emit(state.copyWith(forecast: result, loading: false, failed: false));
      }
    } on Object {
      emit(state.copyWith(loading: false, failed: true));
    }
  }

  Future<void> setCity(City city) async {
    await _repository.setCity(city);
    emit(WeatherState(city: city, forecast: _repository.cached(city)));
    await refresh(force: true);
  }
}
