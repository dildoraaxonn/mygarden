/// Where our own backend lives. Set at build time, e.g.:
///
/// ```sh
/// flutter build apk --dart-define=API_BASE_URL=https://mygarden.example.workers.dev \
///                   --dart-define=API_TOKEN=some-long-random-string
/// ```
///
/// The token only stops casual misuse (it can be read out of the app);
/// real protection is the rate limit on the server.
class ApiConfig {
  const ApiConfig({required this.baseUrl, required this.appToken});

  factory ApiConfig.fromEnvironment() => const ApiConfig(
    baseUrl: String.fromEnvironment('API_BASE_URL'),
    appToken: String.fromEnvironment('API_TOKEN'),
  );

  final String baseUrl;
  final String appToken;

  /// False until a server address is provided; features then use demo data.
  bool get isConfigured => baseUrl.isNotEmpty;
}
