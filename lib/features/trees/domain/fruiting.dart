import '../../../core/database/app_database.dart';

enum FruitingStatus {
  /// The tree is marked as fruiting.
  fruiting,

  /// The expected date has passed but the tree isn't marked as fruiting yet.
  due,

  /// First fruit is expected in the future.
  upcoming,

  /// No planting date, so we can't tell.
  unknown,
}

class FruitingForecast {
  const FruitingForecast(this.status, [this.expectedDate]);

  final FruitingStatus status;
  final DateTime? expectedDate;

  /// Whole months from [now] until the expected date (at least 1).
  int monthsFrom(DateTime now) {
    final date = expectedDate;
    if (date == null) return 0;
    final months = (date.year - now.year) * 12 + date.month - now.month;
    return months < 1 ? 1 : months;
  }
}

FruitingForecast forecastFruiting(Tree tree, FruitType type, DateTime now) {
  if (tree.stage == TreeStage.fruiting) {
    return const FruitingForecast(FruitingStatus.fruiting);
  }
  final planted = tree.plantedOn;
  if (planted == null) return const FruitingForecast(FruitingStatus.unknown);

  final expected = DateTime(
    planted.year,
    planted.month + type.monthsToFruit,
    planted.day,
  );
  return FruitingForecast(
    expected.isAfter(now) ? FruitingStatus.upcoming : FruitingStatus.due,
    expected,
  );
}
