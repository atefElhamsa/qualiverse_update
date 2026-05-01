part of '../end_points.dart';

mixin AuthEndPoints {
  static const String login = "Account/login";
  static const String refreshToken = "Account/refresh";
  static const String register = "Account/register";
  static const String forgotPassword = "Account/forgot-password";
  static const String resetPassword = "Account/reset-password";
  static const String accountVerification = "Account/resend-confirmation-email";
  static const String changePassword = "Account/change-password";
  static const String revoke = "Account/revoke-refresh-token";
}
