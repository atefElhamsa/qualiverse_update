import 'package:qualiverse/routing/all_routes_imports.dart';

class CriterionTemplateResponseModel {
  final bool isSuccess;
  final ApiErrorModel? error;
  final List<CriterionTemplateModel>? data;

  CriterionTemplateResponseModel({
    required this.isSuccess,
    this.error,
    this.data,
  });

  factory CriterionTemplateResponseModel.fromJson(Map<String, dynamic> json) {
    return CriterionTemplateResponseModel(
      isSuccess: json['isSuccess'],
      error: json['error'] != null
          ? ApiErrorModel.fromJson(json['error'])
          : null,
      data: (json['data'] as List)
          .map((e) => CriterionTemplateModel.fromJson(e))
          .toList(),
    );
  }
}

class CriterionTemplateModel {
  final int id;
  final String name;

  const CriterionTemplateModel({required this.id, required this.name});

  factory CriterionTemplateModel.fromJson(Map<String, dynamic> json) {
    return CriterionTemplateModel(id: json['id'], name: json['name']);
  }
}
