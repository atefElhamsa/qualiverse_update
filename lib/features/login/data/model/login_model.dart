import '../../../../core/all_core_imports/all_core_imports.dart';

class LoginModel {
  final LoginDataModel? data;
  final bool isSuccess;
  final ApiErrorModel? error;

  const LoginModel({this.data, required this.isSuccess, this.error});

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      data: json['data'] != null ? LoginDataModel.fromJson(json['data']) : null,
      isSuccess: json['isSuccess'] ?? false,
      error: json['error'] != null
          ? ApiErrorModel.fromJson(json['error'])
          : null,
    );
  }
}

class LoginDataModel {
  final String userId;
  final String email;
  final String role;
  final String token;
  final String refreshToken;
  final DateTime refreshTokenExpiration;
  final bool isActive;

  const LoginDataModel({
    required this.userId,
    required this.email,
    required this.role,
    required this.token,
    required this.refreshToken,
    required this.refreshTokenExpiration,
    this.isActive = true,
  });

  factory LoginDataModel.fromJson(Map<String, dynamic> json) {
    return LoginDataModel(
      userId: json['userId'] ?? '',
      email: json['email'] ?? '',
      role: json['role'] ?? '',
      token: json['token'] ?? '',
      refreshToken: json['refreshToken'] ?? '',
      refreshTokenExpiration:
          DateTime.tryParse(json['refreshTokenExpiration'] ?? '') ??
          DateTime.now(),
      isActive: json['isActive'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'email': email,
      'role': role,
      'token': token,
      'refreshToken': refreshToken,
      'refreshTokenExpiration': refreshTokenExpiration.toIso8601String(),
      'isActive': isActive,
    };
  }

  LoginDataModel copyWith({
    String? userId,
    String? email,
    String? role,
    String? token,
    String? refreshToken,
    DateTime? refreshTokenExpiration,
    bool? isActive,
  }) {
    return LoginDataModel(
      userId: userId ?? this.userId,
      email: email ?? this.email,
      role: role ?? this.role,
      token: token ?? this.token,
      refreshToken: refreshToken ?? this.refreshToken,
      refreshTokenExpiration:
          refreshTokenExpiration ?? this.refreshTokenExpiration,
      isActive: isActive ?? this.isActive,
    );
  }
}
