import 'package:drift/drift.dart';

import 'app_database.dart';

/// Fruit types created on first launch. More can be added in Settings.
/// Months to first fruit are typical values and can be edited in the app.
final seedFruitTypes = [
  // Banana grown from a sucker: usually 9–15 months.
  FruitTypesCompanion.insert(
    nameEn: 'Banana',
    nameRu: 'Банан',
    emoji: const Value('🍌'),
    monthsToFruit: const Value(12),
  ),
  // Papaya from seed: usually 6–12 months.
  FruitTypesCompanion.insert(
    nameEn: 'Papaya',
    nameRu: 'Папайя',
    emoji: const Value('🍈'),
    monthsToFruit: const Value(10),
  ),
  // Grafted mandarin: usually 2–3 years.
  FruitTypesCompanion.insert(
    nameEn: 'Mandarin',
    nameRu: 'Мандарин',
    emoji: const Value('🍊'),
    monthsToFruit: const Value(30),
  ),
];

/// The two greenhouses.
final seedPlots = [
  PlotsCompanion.insert(name: 'Теплица 1', widthM: 10, lengthM: 50),
  PlotsCompanion.insert(name: 'Теплица 2', widthM: 15, lengthM: 50),
];
