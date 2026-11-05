import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// The app language. Russian by default; remembered between launches.
class LocaleCubit extends Cubit<Locale> {
  LocaleCubit(SharedPreferences preferences)
    : _preferences = preferences,
      super(Locale(preferences.getString(_key) ?? 'ru'));

  static const _key = 'locale';
  static const supported = ['ru', 'en'];

  final SharedPreferences _preferences;

  Future<void> setLanguage(String languageCode) async {
    await _preferences.setString(_key, languageCode);
    emit(Locale(languageCode));
  }
}
