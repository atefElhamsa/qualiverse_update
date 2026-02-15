class ApiErrorModel {
  final String code;
  final String description;
  final int statusCode;

  ApiErrorModel({
    required this.code,
    required this.description,
    required this.statusCode,
  });

  factory ApiErrorModel.fromJson(Map<String, dynamic> json) {
    return ApiErrorModel(
      code: json['code'] ?? '',
      description: json['description'] ?? '',
      statusCode: json['statusCode'] ?? 0,
    );
  }
}
