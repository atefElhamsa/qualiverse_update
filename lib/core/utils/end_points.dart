class EndPoints {
  static const String baseUrl = "https://qualiverse.runasp.net/api/";
  static const String baseUrlToOpenFile = "https://qualiverse.runasp.net";
  static const String login = "Account/login";
  static const String refreshToken = "Account/refresh";
  static const String register = "Account/register";
  static const String forgotPassword = "Account/forgot-password";
  static const String accreditationTypes = "Accreditation";
  static const String department = "Department";
  static const String academicYears = "AcademicYear";
  static const String indicator = "Indicator";
  static const String accountVerification = "Account/resend-confirmation-email";
  static const String changePassword = "Account/change-password";

  static String accreditations({
    required int academicYearId,
    int? departmentId,
  }) {
    final buffer = StringBuffer("Criterion?academicYearId=$academicYearId");

    if (departmentId != null) {
      buffer.write("&departmentId=$departmentId");
    }

    return buffer.toString();
  }

  static String indicatorsByCriterionId({required int criterionId}) {
    return "Indicator/$criterionId";
  }
}
