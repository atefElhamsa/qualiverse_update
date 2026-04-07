import 'package:qualiverse/routing/all_routes_imports.dart';

class AccreditationType {
  final bool isSuccess;
  final List<TypeModel>? types;
  final ApiErrorModel? error;

  AccreditationType({required this.isSuccess, this.types, this.error});

  factory AccreditationType.fromJson(Map<String, dynamic> json) {
    return AccreditationType(
      types: (json['data'] as List).map((e) => TypeModel.fromJson(e)).toList(),
      isSuccess: json['isSuccess'],
      error: json['error'] != null
          ? ApiErrorModel.fromJson(json['error'])
          : null,
    );
  }
}

class TypeModel {
  final int id;
  final String name;

  TypeModel({required this.id, required this.name});

  factory TypeModel.fromJson(Map<String, dynamic> json) {
    return TypeModel(id: json['id'], name: json['name']);
  }
}
