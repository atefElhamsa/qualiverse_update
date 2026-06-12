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
      code: json['code']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      statusCode: json['statusCode'] is int
          ? json['statusCode'] as int
          : int.tryParse(json['statusCode']?.toString() ?? '') ?? 0,
    );
  }
}
