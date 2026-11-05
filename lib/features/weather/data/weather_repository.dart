import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'weather_models.dart';

/// Night temperatures from Open-Meteo (free, no account needed).
/// The last forecast is kept so the app still shows something offline.
class WeatherRepository {
  WeatherRepository(this._preferences, {http.Client? client})
    : _client = client ?? http.Client();

  final SharedPreferences _preferences;
  final http.Client _client;

  static const _cityKey = 'weather_city';
  static const _cacheKey = 'weather_cache';

  City get city => cityById(_preferences.getString(_cityKey) ?? 'tashkent');

  Future<void> setCity(City city) => _preferences.setString(_cityKey, city.id);

  /// Last saved forecast for [city], if any.
  Forecast? cached(City city) {
    final raw = _preferences.getString('$_cacheKey.${city.id}');
    if (raw == null) return null;
    try {
      final json = jsonDecode(raw) as Map<String, dynamic>;
      return Forecast.fromOpenMeteo(
        json['response'] as Map<String, dynamic>,
        fetchedAt: DateTime.parse(json['fetchedAt'] as String),
      );
    } on Object {
      return null;
    }
  }

  Future<Forecast> fetch(City city) async {
    final uri = Uri.https('api.open-meteo.com', '/v1/forecast', {
      'latitude': '${city.latitude}',
      'longitude': '${city.longitude}',
      'daily': 'temperature_2m_min,temperature_2m_max',
      'timezone': 'auto',
      'forecast_days': '4',
    });
    final response = await _client
        .get(uri)
        .timeout(const Duration(seconds: 15));
    if (response.statusCode != 200) {
      throw http.ClientException('HTTP ${response.statusCode}', uri);
    }
    final json = jsonDecode(response.body) as Map<String, dynamic>;
    final now = DateTime.now();
    final forecast = Forecast.fromOpenMeteo(json, fetchedAt: now);
    await _preferences.setString(
      '$_cacheKey.${city.id}',
      jsonEncode({'fetchedAt': now.toIso8601String(), 'response': json}),
    );
    return forecast;
  }
}
