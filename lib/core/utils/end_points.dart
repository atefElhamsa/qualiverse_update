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
  static const String roles = "Role";
  static const String terms = "Term";
  static const String updateAndCreateCourseFolder = "CourseFolder";
  static const String evidenceFolders = "EvidenceFolder";
  static const String assignIndicator = "Indicator/assign";
  static const String assignCourse = "Course/assign";
  static const String templates = "Course/templates";
  static const String courseFromTemplate = "Course/from-template";
  static const String newCourse = "Course/new";
  static const String uploadEvidenceGeneral = "EvidenceFolder/upload/general";
  static const String uploadEvidenceStatistics =
      "EvidenceFolder/upload/statistics";
  static const String newCriterion = "Criterion/new";
  static const String createNewIndicator = "Indicator";
  static const String newCriterionFromExistingTemplate =
      "Criterion/from-existing";

  static const String assignmentsStatus = "Enum/AssignmentStatus";
  static const String unreadNotificationCount = "Notification/unread-count";

  static String accreditations({
    required int academicYearId,
    int? departmentId,
    int? accreditationTypeId,
  }) {
    final buffer = StringBuffer("Criterion?academicYearId=$academicYearId");

    if (departmentId != null) {
      buffer.write("&departmentId=$departmentId");
    }

    if (accreditationTypeId != null) {
      buffer.write("&accreditationTypeId=$accreditationTypeId");
    }

    return buffer.toString();
  }

  static String indicatorsByCriterionId({required int criterionId}) {
    return "Indicator/$criterionId";
  }

  static String deleteIndicatorFile({required int indicatorId}) {
    return "Indicator/File/$indicatorId";
  }

  static String deleteIndicator({required int id}) {
    return "Indicator/$id";
  }

  static String deleteEvidenceFile({required int id}) {
    return "EvidenceFolder/file/$id";
  }

  static String courses({
    required int yearId,
    required int levelId,
    required int termId,
    int? departmentId,
  }) {
    final buffer = StringBuffer(
      "Course?yearId=$yearId&levelId=$levelId&termId=$termId",
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

  static String getEvidenceFilesByFolderId({required int folderId}) {
    return "EvidenceFolder/$folderId";
  }

  static String uploadFileToEvidenceFolder({required int folderId}) {
    return "EvidenceFolder/upload";
  }

  static String uploadFileToFolder({required int folderId}) {
    return "CourseFolder/$folderId/upload";
  }

  static String deleteFileFromFolder({
    required int folderId,
    required int fileId,
  }) {
    return "CourseFolder/$folderId/files/$fileId";
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

  static String deleteCourse({required int courseId}) {
    return "Course/$courseId";
  }

  static String academicYearAdded({required int yearNumber}) {
    return "AcademicYear?yearNumber=$yearNumber";
  }

  static String removeAssignIndicator({required int indicatorId}) {
    return "Indicator/$indicatorId/delete-assign";
  }

  static String removeAssignCourse({required int courseId}) {
    return "Course/$courseId/assign";
  }

  static String getDashboard({
    int? yearId,
    int? departmentId,
    int? levelId,
    int? accreditationTypeId,
  }) {
    final List<String> params = [];
    if (yearId != null) params.add("AcademicYearId=$yearId");
    if (departmentId != null) params.add("DepartmentId=$departmentId");
    if (levelId != null) params.add("LevelId=$levelId");
    if (accreditationTypeId != null) {
      params.add("AccreditationTypeId=$accreditationTypeId");
    }

    return "Dashboard${params.isEmpty ? "" : "?${params.join("&")}"}";
  }

  static String getCycleIndicators({
    required int yearId,
    int? departmentId,
    required int criterionId,
  }) {
    final buffer = StringBuffer("Indicator?AcademicYearId=$yearId");
    if (departmentId != null) {
      buffer.write("&DepartmentId=$departmentId");
    }
    buffer.write("&CriterionId=$criterionId");
    return buffer.toString();
  }

  static String coursesByDepartment({
    required int academicYearId,
    int? departmentId,
    required int levelId,
    required int termId,
  }) {
    final buffer = StringBuffer(
      "Course/all?AcademicYearId=$academicYearId&LevelId=$levelId&TermId=$termId",
    );
    if (departmentId != null) {
      buffer.write("&DepartmentId=$departmentId");
    }
    return buffer.toString();
  }

  static String getAllCriterions({
    required int academicYearId,
    int? accreditationTypeId,
    int? departmentId,
  }) {
    final buffer = StringBuffer("Criterion/all?AcademicYearId=$academicYearId");
    if (departmentId != null) {
      buffer.write("&DepartmentId=$departmentId");
    }
    if (accreditationTypeId != null) {
      buffer.write("&AccreditationTypeId=$accreditationTypeId");
    }
    return buffer.toString();
  }

  static String getTemplateCriteria({required int accreditationTypeId}) {
    return "Criterion/templates?AccreditationTypeId=$accreditationTypeId";
  }

  static String toggleCriterionStatus({required int criterionId}) {
    return "Criterion/$criterionId/toggle-status";
  }

  static String getEvidenceFileGeneralFolder({
    required int id,
    int? departmentId,
    required int academicYearId,
    required int termId,
    required int levelId,
    required int courseId,
  }) {
    final buffer = StringBuffer(
      "EvidenceFolder/general?id=$id&academicYearId=$academicYearId&termId=$termId&levelId=$levelId&courseId=$courseId",
    );

    if (departmentId != null) {
      buffer.write("&departmentId=$departmentId");
    }

    return buffer.toString();
  }

  static String getEvidenceStatistics({
    int? departmentId,
    required int academicYearId,
    required int termId,
    required int levelId,
  }) {
    final buffer = StringBuffer(
      "EvidenceFolder/statistics?academicYearId=$academicYearId&termId=$termId&levelId=$levelId",
    );

    if (departmentId != null) {
      buffer.write("&departmentId=$departmentId");
    }

    return buffer.toString();
  }

  static String getFileData({
    int? departmentId,
    required int academicYearId,
    required int termId,
    required int levelId,
    required int courseId,
  }) {
    final buffer = StringBuffer("EvidenceFolder/data?");
    buffer.write("academicYearId=$academicYearId");
    buffer.write("&termId=$termId");
    buffer.write("&levelId=$levelId");
    buffer.write("&courseId=$courseId");
    if (departmentId != null) {
      buffer.write("&departmentId=$departmentId");
    }
    return buffer.toString();
  }

  static String userRole({required String userId}) => "Role/user/$userId";

  static String getAssignmentInidicatorAdmin({
    required int academicYearId,
    String? doctorId,
    int? status,
  }) {
    final buffer = StringBuffer("Indicator/assignments?");
    buffer.write("AcademicYearId=$academicYearId");
    if (doctorId != null) {
      buffer.write("&DoctorId=$doctorId");
    }
    if (status != null) {
      buffer.write("&Status=$status");
    }
    return buffer.toString();
  }

  static String approveAssignmentIndicator({required int indicatorId}) {
    return "Indicator/$indicatorId/approve";
  }

  static String rejectAssignmentIndicator({required int indicatorId}) {
    return "Indicator/$indicatorId/reject";
  }

  static String getMyAssignments({required int academicYearId, int? status}) {
    final buffer = StringBuffer("Indicator/assignments/me?");
    buffer.write("academicYearId=$academicYearId");
    if (status != null) {
      buffer.write("&status=$status");
    }
    return buffer.toString();
  }

  static String getAllNotifications({
    required int pageIndex,
    required int pageSize,
    bool? isRead,
  }) {
    final buffer = StringBuffer(
      "Notification?PageIndex=$pageIndex&PageSize=$pageSize",
    );
    if (isRead != null) {
      buffer.write("&IsRead=$isRead");
    }
    return buffer.toString();
  }

  static String getUnreadNotificationCount() => "Notification/unread-count";

  static String deleteNotification({required int id}) => "Notification/$id";

  static String markNotificationAsRead({required int id}) =>
      "Notification/$id/read";

  static String markAllNotificationsAsRead() => "Notification/read-all";

  static String cleanupNotifications({int daysRetention = 30}) =>
      "Notification/cleanup?daysRetention=$daysRetention";
}
