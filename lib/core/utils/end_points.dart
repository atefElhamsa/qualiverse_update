class EndPoints {
  static const String baseUrl = "https://qualiverse.runasp.net/api/";
  static const String login = "Account/login";
  static const String refreshToken = "Account/refresh";
  static const String register = "Account/register";
  static const String forgotPassword = "Account/forgot-password";
  static const String accreditationTypes = "accreditations";
  static const String department = "Department";
  static const String academicYears = "AcademicYear";

  static String accreditations({
    required int academicYearId,
    int? departmentId,
  }) {
    final buffer = StringBuffer(
      "accreditation/criterion?academicYearId=$academicYearId",
    );

    if (departmentId != null) {
      buffer.write("&departmentId=$departmentId");
    }

    return buffer.toString();
  }
}
