import 'package:qualiverse/routing/all_routes_imports.dart';

class TemplateResponseModel {
  final List<TemplateModel>? templates;
  final bool isSuccess;
  final ApiErrorModel? error;

  TemplateResponseModel({this.templates, required this.isSuccess, this.error});

  factory TemplateResponseModel.fromJson(Map<String, dynamic> json) {
    return TemplateResponseModel(
      isSuccess: json['isSuccess'] ?? false,
      templates: (json['data'] as List)
          .map((x) => TemplateModel.fromJson(x))
          .toList(),
      error: json['error'] != null
          ? ApiErrorModel.fromJson(json['error'])
          : null,
    );
  }
}

class TemplateModel {
  final int id;
  final String name;

  TemplateModel({required this.id, required this.name});

  factory TemplateModel.fromJson(Map<String, dynamic> json) {
    return TemplateModel(id: json['id'], name: json['name']);
  }
}
