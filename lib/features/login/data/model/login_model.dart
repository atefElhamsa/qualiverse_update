class LoginModel {
  final String userId;
  final String email;
  final String role;
  final String token;
  final String refreshToken;
  final DateTime refreshTokenExpiration;
  final bool isActive;

  const LoginModel({
    required this.userId,
    required this.email,
    required this.role,
    required this.token,
    required this.refreshToken,
    required this.refreshTokenExpiration,
    this.isActive = true,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      userId: json['userId'] as String,
      email: json['email'] as String,
      role: json['role'] as String,
      token: json['token'] as String,
      refreshToken: json['refreshToken'] as String,
      refreshTokenExpiration: DateTime.parse(
        json['refreshTokenExpiration'] as String,
      ),
      isActive: json['isActive'] as bool,
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

  LoginModel copyWith({
    String? userId,
    String? email,
    String? role,
    String? token,
    String? refreshToken,
    DateTime? refreshTokenExpiration,
    bool? isActive,
  }) {
    return LoginModel(
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
