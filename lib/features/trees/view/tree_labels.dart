import 'package:flutter/material.dart';

import '../../../core/database/app_database.dart';
import '../../../core/l10n/generated/app_localizations.dart';
import '../../../core/utils/format.dart';
import '../domain/fruiting.dart';

extension TreeStageLabel on TreeStage {
  String label(AppLocalizations l10n) => switch (this) {
    TreeStage.seedling => l10n.stageSeedling,
    TreeStage.growing => l10n.stageGrowing,
    TreeStage.flowering => l10n.stageFlowering,
    TreeStage.fruiting => l10n.stageFruiting,
  };

  Color color(ColorScheme scheme) => switch (this) {
    TreeStage.seedling => scheme.surfaceContainerHighest,
    TreeStage.growing => scheme.primaryContainer,
    TreeStage.flowering => scheme.tertiaryContainer,
    TreeStage.fruiting => Colors.orange.shade200,
  };
}

String forecastLabel(BuildContext context, FruitingForecast forecast) {
  final l10n = AppLocalizations.of(context);
  return switch (forecast.status) {
    FruitingStatus.fruiting => l10n.fruitingNow,
    FruitingStatus.due => l10n.fruitingDue,
    FruitingStatus.unknown => l10n.fruitingNeedsDate,
    FruitingStatus.upcoming => l10n.fruitingIn(
      formatDate(context, forecast.expectedDate!),
      forecast.monthsFrom(DateTime.now()),
    ),
  };
}
