import 'package:equatable/equatable.dart';

class City extends Equatable {
  const City(this.id, this.nameRu, this.nameEn, this.latitude, this.longitude);

  final String id;
  final String nameRu;
  final String nameEn;
  final double latitude;
  final double longitude;

  String name(String languageCode) => languageCode == 'ru' ? nameRu : nameEn;

  @override
  List<Object?> get props => [id];
}

/// Regional centres of Uzbekistan.
const uzbekCities = [
  City('tashkent', 'Ташкент', 'Tashkent', 41.31, 69.28),
  City('samarkand', 'Самарканд', 'Samarkand', 39.65, 66.96),
  City('bukhara', 'Бухара', 'Bukhara', 39.77, 64.42),
  City('andijan', 'Андижан', 'Andijan', 40.78, 72.34),
  City('namangan', 'Наманган', 'Namangan', 41.00, 71.67),
  City('fergana', 'Фергана', 'Fergana', 40.38, 71.79),
  City('gulistan', 'Гулистан', 'Gulistan', 40.49, 68.78),
  City('jizzakh', 'Джизак', 'Jizzakh', 40.12, 67.84),
  City('navoi', 'Навои', 'Navoi', 40.10, 65.38),
  City('karshi', 'Карши', 'Karshi', 38.86, 65.79),
  City('termez', 'Термез', 'Termez', 37.22, 67.28),
  City('urgench', 'Ургенч', 'Urgench', 41.55, 60.63),
  City('nukus', 'Нукус', 'Nukus', 42.46, 59.60),
];

City cityById(String id) =>
    uzbekCities.firstWhere((c) => c.id == id, orElse: () => uzbekCities.first);

enum ColdLevel {
  /// Below 0 °C outside: frost.
  frost,

  /// 0–5 °C outside: cold night, a homemade greenhouse can drop below the
  /// ~10 °C that bananas and papayas need.
  cold,
  ok,
}

ColdLevel coldLevelFor(double minC) => minC <= 0
    ? ColdLevel.frost
    : minC <= 5
    ? ColdLevel.cold
    : ColdLevel.ok;

class DayForecast extends Equatable {
  const DayForecast({
    required this.date,
    required this.minC,
    required this.maxC,
  });

  final DateTime date;
  final double minC;
  final double maxC;

  @override
  List<Object?> get props => [date, minC, maxC];
}

class Forecast extends Equatable {
  const Forecast({required this.days, required this.fetchedAt});

  /// Parses an Open-Meteo `daily` response.
  factory Forecast.fromOpenMeteo(
    Map<String, dynamic> json, {
    required DateTime fetchedAt,
  }) {
    final daily = json['daily'] as Map<String, dynamic>;
    final dates = (daily['time'] as List).cast<String>();
    final mins = daily['temperature_2m_min'] as List;
    final maxs = daily['temperature_2m_max'] as List;
    return Forecast(
      fetchedAt: fetchedAt,
      days: [
        for (var i = 0; i < dates.length; i++)
          if (mins[i] != null && maxs[i] != null)
            DayForecast(
              date: DateTime.parse(dates[i]),
              minC: (mins[i] as num).toDouble(),
              maxC: (maxs[i] as num).toDouble(),
            ),
      ],
    );
  }

  final List<DayForecast> days;
  final DateTime fetchedAt;

  /// The coldest day in the forecast.
  DayForecast? get coldest =>
      days.isEmpty ? null : days.reduce((a, b) => b.minC < a.minC ? b : a);

  @override
  List<Object?> get props => [days, fetchedAt];
}
