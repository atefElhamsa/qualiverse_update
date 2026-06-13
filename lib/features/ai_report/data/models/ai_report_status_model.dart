class AiReportHealthModel {
  final String status;
  final String version;
  final String provider;
  final String timestamp;
  final bool isSuccess;

  AiReportHealthModel({
    required this.status,
    required this.version,
    required this.provider,
    required this.timestamp,
    required this.isSuccess,
  });

  factory AiReportHealthModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] ?? {};
    return AiReportHealthModel(
      status: data['status'] ?? 'unknown',
      version: data['version'] ?? 'unknown',
      provider: data['provider'] ?? 'unknown',
      timestamp: data['timestamp'] ?? '',
      isSuccess: json['isSuccess'] ?? false,
    );
  }
}

class ProviderConfig {
  final bool configured;
  final String model;
  final String? baseUrl;

  ProviderConfig({
    required this.configured,
    required this.model,
    this.baseUrl,
  });

  factory ProviderConfig.fromJson(Map<String, dynamic> json) {
    return ProviderConfig(
      configured: json['configured'] ?? false,
      model: json['model'] ?? 'unknown',
      baseUrl: json['base_url'],
    );
  }
}

class AiReportProvidersModel {
  final String currentProvider;
  final Map<String, ProviderConfig> providers;
  final bool isSuccess;

  AiReportProvidersModel({
    required this.currentProvider,
    required this.providers,
    required this.isSuccess,
  });

  factory AiReportProvidersModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] ?? {};
    final currentProvider = data['current_provider'] ?? 'unknown';
    final providersMap = <String, ProviderConfig>{};
    if (data['providers'] != null) {
      (data['providers'] as Map<String, dynamic>).forEach((key, value) {
        providersMap[key] = ProviderConfig.fromJson(value as Map<String, dynamic>);
      });
    }
    return AiReportProvidersModel(
      currentProvider: currentProvider,
      providers: providersMap,
      isSuccess: json['isSuccess'] ?? false,
    );
  }
}
