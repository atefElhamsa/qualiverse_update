import '../../../../core/all_core_imports/all_core_imports.dart';

class TermResponseModel {
  final List<TermModel>? terms;
  final bool isSuccess;
  final ApiErrorModel? error;

  TermResponseModel({required this.isSuccess, this.terms, this.error});

  factory TermResponseModel.fromJson(Map<String, dynamic> json) {
    return TermResponseModel(
      terms: (json['data'] as List).map((e) => TermModel.fromJson(e)).toList(),
      isSuccess: json['isSuccess'] ?? false,
      error: json['error'] != null
          ? ApiErrorModel.fromJson(json['error'])
          : null,
    );
  }
}

class TermModel {
  final int id;
  final int termNumber;
  final String name;

  const TermModel({
    required this.id,
    required this.termNumber,
    required this.name,
  });

  factory TermModel.fromJson(Map<String, dynamic> json) => TermModel(
    id: json['id'] as int,
    termNumber: json['termNumber'] as int,
    name: json['name'] as String,
  );
}
