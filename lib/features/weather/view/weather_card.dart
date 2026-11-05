import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../core/l10n/generated/app_localizations.dart';
import '../cubit/weather_cubit.dart';
import '../data/weather_models.dart';

/// Night temperatures for the next days, with a frost warning.
class WeatherCard extends StatelessWidget {
  const WeatherCard({super.key});

  String _temp(double c) => '${c.round() > 0 ? '+' : ''}${c.round()}°';

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final language = Localizations.localeOf(context).languageCode;
    final theme = Theme.of(context);
    return BlocBuilder<WeatherCubit, WeatherState>(
      builder: (context, state) {
        final forecast = state.forecast;
        final coldest = forecast?.coldest;
        final level = coldest == null ? null : coldLevelFor(coldest.minC);
        final (background, foreground) = switch (level) {
          ColdLevel.frost => (
            theme.colorScheme.errorContainer,
            theme.colorScheme.onErrorContainer,
          ),
          ColdLevel.cold => (Colors.orange.shade100, Colors.brown.shade900),
          _ => (
            theme.colorScheme.secondaryContainer,
            theme.colorScheme.onSecondaryContainer,
          ),
        };
        final weekday = DateFormat.E(language);

        return Card(
          color: background,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: DefaultTextStyle.merge(
              style: TextStyle(color: foreground),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(switch (level) {
                        ColdLevel.frost => '🥶',
                        ColdLevel.cold => '🌡️',
                        _ => '🌙',
                      }, style: const TextStyle(fontSize: 28)),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              switch (level) {
                                ColdLevel.frost => l10n.weatherFrost,
                                ColdLevel.cold => l10n.weatherCold,
                                ColdLevel.ok => l10n.weatherOk,
                                null => l10n.weatherTitle,
                              },
                              style: theme.textTheme.titleMedium?.copyWith(
                                color: foreground,
                              ),
                            ),
                            Text(
                              state.city.name(language),
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: foreground,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (state.loading)
                        const SizedBox.square(
                          dimension: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      else
                        IconButton(
                          tooltip: l10n.weatherRefresh,
                          color: foreground,
                          icon: const Icon(Icons.refresh),
                          onPressed: () =>
                              context.read<WeatherCubit>().refresh(force: true),
                        ),
                    ],
                  ),
                  if (level == ColdLevel.frost || level == ColdLevel.cold)
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(l10n.weatherAdvice),
                    ),
                  const SizedBox(height: 12),
                  if (forecast == null)
                    Text(state.failed ? l10n.weatherOffline : '…')
                  else
                    Row(
                      children: [
                        for (final day in forecast.days)
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  weekday.format(day.date),
                                  style: theme.textTheme.labelMedium?.copyWith(
                                    color: foreground,
                                  ),
                                ),
                                Text(
                                  _temp(day.minC),
                                  style: theme.textTheme.titleLarge?.copyWith(
                                    color: foreground,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  _temp(day.maxC),
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: foreground,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  if (forecast != null && state.failed)
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        l10n.weatherOld,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: foreground,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
