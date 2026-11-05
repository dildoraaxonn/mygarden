import 'package:flutter/widgets.dart';

import '../../core/database/app_database.dart';

extension FruitTypeName on FruitType {
  /// Name in the app's current language.
  String localizedName(BuildContext context) =>
      Localizations.localeOf(context).languageCode == 'ru' ? nameRu : nameEn;

  /// Emoji + name, e.g. "🍌 Banana".
  String label(BuildContext context) => '$emoji ${localizedName(context)}';
}
