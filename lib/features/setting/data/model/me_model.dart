import '../../../../core/all_core_imports/all_core_imports.dart';

class MeResponse {
  final bool isSuccess;
  final MeModel? data;
  final ApiErrorModel? error;

  MeResponse({required this.isSuccess, this.data, this.error});

  factory MeResponse.fromJson(Map<String, dynamic> json) {
    return MeResponse(
      isSuccess: json['isSuccess'] ?? false,
      data: json['data'] != null ? MeModel.fromJson(json['data']) : null,
      error: json['error'] != null
          ? ApiErrorModel.fromJson(json['error'])
          : null,
    );
  }
}

class MeModel {
  final String id;
  final String email;
  final String firstName;
  final String userName;
  final String lastName;
  final String role;
  final bool isActive;

  MeModel({
    required this.id,
    required this.email,
    required this.firstName,
    required this.userName,
    required this.lastName,
    required this.role,
    required this.isActive,
  });

  factory MeModel.fromJson(Map<String, dynamic> json) => MeModel(
    id: json['id'],
    email: json['email'],
    firstName: json['firstName'],
    userName: json['userName'],
    lastName: json['lastName'],
    role: json['role'],
    isActive: json['isActive'],
  );
}
