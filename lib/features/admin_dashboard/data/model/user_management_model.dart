import 'package:qualiverse/routing/all_routes_imports.dart';

class UserManagementResponseModel {
  final bool isSuccess;
  final ApiErrorModel? error;
  final List<UserManagementModel>? data;

  UserManagementResponseModel({required this.isSuccess, this.error, this.data});

  factory UserManagementResponseModel.fromJson(Map<String, dynamic> json) {
    return UserManagementResponseModel(
      isSuccess: json['isSuccess'] ?? false,
      error: json['error'] != null
          ? ApiErrorModel.fromJson(json['error'])
          : null,
      data: json['data']
          ?.map<UserManagementModel>(
            (item) => UserManagementModel.fromJson(item),
          )
          .toList(),
    );
  }
}

class UserManagementModel {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final bool isActive;
  final List<String> roles;

  UserManagementModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.isActive,
    required this.roles,
  });

  String get fullName => '$firstName $lastName';

  String get role => roles.isNotEmpty ? roles.first : 'N/A';

  String get status => isActive ? 'Active' : 'Inactive';

  factory UserManagementModel.fromJson(Map<String, dynamic> json) {
    return UserManagementModel(
      id: json['id'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      email: json['email'] ?? '',
      isActive: json['isActive'] ?? false,
      roles: List<String>.from(json['roles'] ?? []),
    );
  }
}
