import 'package:flutter/material.dart';

ThemeData buildTheme(Brightness brightness) {
  final scheme = ColorScheme.fromSeed(
    seedColor: const Color(0xFF2E7D32),
    brightness: brightness,
  );
  return ThemeData(
    colorScheme: scheme,
    // Big tap targets: the app is used outdoors, often with one hand.
    materialTapTargetSize: MaterialTapTargetSize.padded,
    cardTheme: const CardThemeData(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    ),
    listTileTheme: const ListTileThemeData(
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    ),
  );
}
