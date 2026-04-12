class EndPoints {
  static const String baseUrl = "https://qualiverse.runasp.net/api/";
  static const String baseUrlToOpenFile = "https://qualiverse.runasp.net";
  static const String login = "Account/login";
  static const String refreshToken = "Account/refresh";
  static const String register = "Account/register";
  static const String forgotPassword = "Account/forgot-password";
  static const String resetPassword = "Account/reset-password";
  static const String accreditationTypes = "Accreditation";
  static const String department = "Department";
  static const String academicYears = "AcademicYear";
  static const String indicator = "Indicator";
  static const String accountVerification = "Account/resend-confirmation-email";
  static const String changePassword = "Account/change-password";
  static const String levels = "Level";
  static const String revoke = "Account/revoke-refresh-token";
  static const String me = "User/me";
  static const String user = "User";
  static const String semesters = "Semester";
  static const String updateAndCreateCourseFolder = "CourseFolder";
  static const String evidenceFolders = "EvidenceFolder";

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

  static String deleteIndicatorFile({required int indicatorId}) {
    return "Indicator/File/$indicatorId";
  }

  static String courses({
    required int yearId,
    required int levelId,
    required int semesterId,
    int? departmentId,
  }) {
    final buffer = StringBuffer(
      "Course?yearId=$yearId&levelId=$levelId&semesterId=$semesterId",
    );

    if (departmentId != null) {
      buffer.write("&departmentId=$departmentId");
    }

    return buffer.toString();
  }

  static String getCourseFolders({required int courseId}) {
    return "CourseFolder/$courseId";
  }

  static String deleteCourseFolder({required int folderId}) {
    return "CourseFolder/$folderId";
  }

  static String getFolderFiles({required int folderId}) {
    return "CourseFolder/File?folderId=$folderId";
  }

  static String activateUser({required String id}) {
    return "User/$id/activate";
  }

  static String deactivateUser({required String id}) {
    return "User/$id/deactivate";
  }

  static String deleteUser({required String id}) {
    return "User/$id";
  }
}
