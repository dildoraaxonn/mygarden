import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/database/app_database.dart';
import '../core/network/api_client.dart';
import '../core/network/api_config.dart';
import '../core/l10n/generated/app_localizations.dart';
import '../core/storage/photo_storage.dart';
import '../features/diagnosis/data/diagnosis_api.dart';
import '../features/diagnosis/data/diagnosis_repository.dart';
import '../features/diagnosis/data/gemini/gemini_diagnosis_api.dart';
import '../features/fruit_types/cubit/fruit_types_cubit.dart';
import '../features/fruit_types/data/fruit_type_repository.dart';
import '../features/journal/data/journal_repository.dart';
import '../features/plots/data/plot_repository.dart';
import '../features/records/data/records_repository.dart';
import '../features/settings/cubit/locale_cubit.dart';
import '../features/trees/data/tree_repository.dart';
import '../features/weather/cubit/weather_cubit.dart';
import '../features/weather/data/weather_repository.dart';
import 'home_shell.dart';
import 'theme.dart';

class MyGardenApp extends StatelessWidget {
  const MyGardenApp({
    super.key,
    required this.database,
    required this.photoStorage,
    required this.preferences,
    this.weatherRepository,
    this.diagnosisApi,
  });

  final AppDatabase database;
  final PhotoStorage photoStorage;
  final SharedPreferences preferences;

  /// Override for tests; created from [preferences] when null.
  final WeatherRepository? weatherRepository;

  /// Override for tests. Otherwise picked from build settings:
  /// our server (API_BASE_URL) → Gemini directly (GEMINI_API_KEY) → demo.
  final DiagnosisApi? diagnosisApi;

  static DiagnosisApi _defaultDiagnosisApi() {
    final server = ApiConfig.fromEnvironment();
    if (server.isConfigured) return RemoteDiagnosisApi(ApiClient(server));
    final gemini = GeminiConfig.fromEnvironment();
    if (gemini.isConfigured) return GeminiDiagnosisApi(gemini);
    return const DemoDiagnosisApi();
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: photoStorage),
        RepositoryProvider(create: (_) => FruitTypeRepository(database)),
        RepositoryProvider(create: (_) => PlotRepository(database)),
        RepositoryProvider(
          create: (_) => TreeRepository(database, photoStorage),
        ),
        RepositoryProvider(create: (_) => JournalRepository(database)),
        RepositoryProvider(create: (_) => RecordsRepository(database)),
        RepositoryProvider(
          create: (_) => weatherRepository ?? WeatherRepository(preferences),
        ),
        RepositoryProvider(
          create: (context) => DiagnosisRepository(
            database,
            context.read<TreeRepository>(),
            diagnosisApi ?? _defaultDiagnosisApi(),
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => LocaleCubit(preferences)),
          BlocProvider(
            create: (context) =>
                FruitTypesCubit(context.read<FruitTypeRepository>()),
          ),
          BlocProvider(
            create: (context) =>
                WeatherCubit(context.read<WeatherRepository>()),
          ),
        ],
        child: BlocBuilder<LocaleCubit, Locale>(
          builder: (context, locale) => MaterialApp(
            onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
            debugShowCheckedModeBanner: false,
            locale: locale,
            supportedLocales: AppLocalizations.supportedLocales,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            theme: buildTheme(Brightness.light),
            darkTheme: buildTheme(Brightness.dark),
            home: const HomeShell(),
          ),
        ),
      ),
    );
  }
}
