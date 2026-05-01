class EndPointFunctions {
  static String accreditations({required int academicYearId, int? departmentId}) {
    final buffer = StringBuffer("Criterion?academicYearId=$academicYearId");
    if (departmentId != null) buffer.write("&departmentId=$departmentId");
    return buffer.toString();
  }

  static String indicatorsByCriterionId({required int criterionId}) => "Indicator/$criterionId";
  static String deleteIndicatorFile({required int indicatorId}) => "Indicator/File/$indicatorId";
  static String deleteIndicator({required int id}) => "Indicator/$id";
  static String deleteEvidenceFile({required int id}) => "EvidenceFolder/file/$id";

  static String courses({required int yearId, required int levelId, required int termId, int? departmentId}) {
    final buffer = StringBuffer("Course?yearId=$yearId&levelId=$levelId&termId=$termId");
    if (departmentId != null) buffer.write("&departmentId=$departmentId");
    return buffer.toString();
  }

  static String getCourseFolders({required int courseId}) => "CourseFolder/$courseId";
  static String deleteCourseFolder({required int folderId}) => "CourseFolder/$folderId";
  static String getFolderFiles({required int folderId}) => "CourseFolder/File?folderId=$folderId";
  static String getEvidenceFilesByFolderId({required int folderId}) => "EvidenceFolder/$folderId";
  static String uploadFileToEvidenceFolder({required int folderId}) => "EvidenceFolder/upload";
  static String uploadFileToFolder({required int folderId}) => "CourseFolder/$folderId/upload";
  static String deleteFileFromFolder({required int folderId, required int fileId}) => "CourseFolder/$folderId/files/$fileId";
  static String activateUser({required String id}) => "User/$id/activate";
  static String deactivateUser({required String id}) => "User/$id/deactivate";
  static String deleteUser({required String id}) => "User/$id";
  static String deleteCourse({required int courseId}) => "Course/$courseId";
  static String academicYearAdded({required int yearNumber}) => "AcademicYear?yearNumber=$yearNumber";
  static String removeAssignIndicator({required int indicatorId}) => "Indicator/$indicatorId/delete-assign";
  static String removeAssignCourse({required int courseId}) => "Course/$courseId/assign";

  static String getDashboard({int? yearId, int? departmentId, int? levelId, int? accreditationTypeId}) {
    final List<String> params = [];
    if (yearId != null) params.add("AcademicYearId=$yearId");
    if (departmentId != null) params.add("DepartmentId=$departmentId");
    if (levelId != null) params.add("LevelId=$levelId");
    if (accreditationTypeId != null) params.add("AccreditationTypeId=$accreditationTypeId");
    return "Dashboard${params.isEmpty ? "" : "?${params.join("&")}"}";
  }

  static String getCycleIndicators({required int yearId, int? departmentId, int? criterionId}) {
    final buffer = StringBuffer("Indicator?AcademicYearId=$yearId");
    if (departmentId != null) buffer.write("&DepartmentId=$departmentId");
    if (criterionId != null) buffer.write("&CriterionId=$criterionId");
    return buffer.toString();
  }

  static String coursesByDepartment({required int academicYearId, required int departmentId, required int levelId, required int termId}) => 
    "Course/all?AcademicYearId=$academicYearId&DepartmentId=$departmentId&LevelId=$levelId&TermId=$termId";

  static String getAllCriterions({required int academicYearId, int? accreditationTypeId, int? departmentId}) {
    final buffer = StringBuffer("Criterion/all?AcademicYearId=$academicYearId");
    if (departmentId != null) buffer.write("&DepartmentId=$departmentId");
    if (accreditationTypeId != null) buffer.write("&AccreditationTypeId=$accreditationTypeId");
    return buffer.toString();
  }

  static String getTemplateCriteria({required int accreditationTypeId}) => "Criterion/templates?AccreditationTypeId=$accreditationTypeId";
  static String toggleCriterionStatus({required int criterionId}) => "Criterion/$criterionId/toggle-status";

  static String getEvidenceFileGeneralFolder({required int id, int? departmentId, required int academicYearId, required int termId, required int levelId, required int courseId}) {
    final buffer = StringBuffer("EvidenceFolder/general?id=$id");
    if (departmentId != null) buffer.write("&departmentId=$departmentId");
    buffer.write("&academicYearId=$academicYearId&termId=$termId&levelId=$levelId&courseId=$courseId");
    return buffer.toString();
  }

  static String getEvidenceStatistics({int? departmentId, required int academicYearId, required int termId, required int levelId}) {
    final buffer = StringBuffer("EvidenceFolder/statistics?academicYearId=$academicYearId&termId=$termId&levelId=$levelId");
    if (departmentId != null) buffer.write("&departmentId=$departmentId");
    return buffer.toString();
  }
}
