import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/app.dart';
import 'core/database/app_database.dart';
import 'core/storage/photo_storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Portrait everywhere; greenhouse maps switch to landscape themselves.
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await initializeDateFormatting();
  final preferences = await SharedPreferences.getInstance();
  final photoStorage = await PhotoStorage.open();

  runApp(
    MyGardenApp(
      database: AppDatabase(),
      photoStorage: photoStorage,
      preferences: preferences,
    ),
  );
}
