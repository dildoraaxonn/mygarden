import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/l10n/generated/app_localizations.dart';
import '../../../core/widgets/section_header.dart';
import '../../fruit_types/view/fruit_types_page.dart';
import '../../weather/cubit/weather_cubit.dart';
import '../../weather/data/weather_models.dart';
import '../cubit/locale_cubit.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  static const _languageNames = {'ru': 'Русский', 'en': 'English'};

  Future<void> _pickCity(BuildContext context) async {
    final l10n = AppLocalizations.of(context);
    final weather = context.read<WeatherCubit>();
    final language = Localizations.localeOf(context).languageCode;
    final city = await showDialog<City>(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text(l10n.settingsCity),
        children: [
          for (final c in uzbekCities)
            ListTile(
              title: Text(c.name(language)),
              trailing: c == weather.state.city
                  ? const Icon(Icons.check)
                  : null,
              onTap: () => Navigator.pop(context, c),
            ),
        ],
      ),
    );
    if (city != null) await weather.setCity(city);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final current = context.watch<LocaleCubit>().state.languageCode;
    final city = context.select((WeatherCubit c) => c.state.city);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.navSettings)),
      body: ListView(
        children: [
          SectionHeader(l10n.settingsLanguage),
          for (final code in LocaleCubit.supported)
            ListTile(
              leading: const Icon(Icons.language),
              title: Text(_languageNames[code]!),
              trailing: code == current
                  ? Icon(
                      Icons.check,
                      color: Theme.of(context).colorScheme.primary,
                    )
                  : null,
              onTap: () => context.read<LocaleCubit>().setLanguage(code),
            ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.location_city_outlined),
            title: Text(l10n.settingsCity),
            subtitle: Text(city.name(current)),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _pickCity(context),
          ),
          ListTile(
            leading: const Icon(Icons.category_outlined),
            title: Text(l10n.settingsFruitTypes),
            subtitle: Text(l10n.settingsFruitTypesHint),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => FruitTypesPage.open(context),
          ),
        ],
      ),
    );
  }
}
