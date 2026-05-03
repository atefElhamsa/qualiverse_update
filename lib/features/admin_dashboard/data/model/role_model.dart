import 'package:qualiverse/routing/all_routes_imports.dart';

class RoleResponseModel {
  final List<RoleModel>? roles;
  final bool isSuccess;
  final ApiErrorModel? error;

  RoleResponseModel({this.roles, required this.isSuccess, this.error});

  factory RoleResponseModel.fromJson(Map<String, dynamic> json) {
    return RoleResponseModel(
      roles: json['data'] != null
          ? (json['data'] as List).map((e) => RoleModel.fromJson(e)).toList()
          : [],
      isSuccess: json['isSuccess'] ?? false,
      error: json['error'] != null
          ? ApiErrorModel.fromJson(json['error'])
          : null,
    );
  }
}

class RoleModel {
  final String id;
  final String name;

  RoleModel({required this.id, required this.name});

  factory RoleModel.fromJson(Map<String, dynamic> json) {
    return RoleModel(id: json['id'], name: json['name']);
  }
}
