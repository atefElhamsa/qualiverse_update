part of '../end_points.dart';

mixin AdminEndPoints {
  static const String accreditationTypes = "Accreditation";
  static const String department = "Department";
  static const String academicYears = "AcademicYear";
  static const String indicator = "Indicator";
  static const String levels = "Level";
  static const String me = "User/me";
  static const String user = "User";
  static const String terms = "Term";
  static const String assignIndicator = "Indicator/assign";
  static const String newCriterion = "Criterion/new";
  static const String createNewIndicator = "Indicator";
  static const String newCriterionFromExistingTemplate = "Criterion/from-existing";

  static String accreditations({required int academicYearId, int? departmentId}) {
    final buffer = StringBuffer("Criterion?academicYearId=$academicYearId");
    if (departmentId != null) buffer.write("&departmentId=$departmentId");
    return buffer.toString();
  }

  static String indicatorsByCriterionId({required int criterionId}) => "Indicator/$criterionId";
  static String deleteIndicatorFile({required int indicatorId}) => "Indicator/File/$indicatorId";
  static String deleteIndicator({required int id}) => "Indicator/$id";
  static String activateUser({required String id}) => "User/$id/activate";
  static String deactivateUser({required String id}) => "User/$id/deactivate";
  static String deleteUser({required String id}) => "User/$id";
  static String academicYearAdded({required int yearNumber}) => "AcademicYear?yearNumber=$yearNumber";
  static String removeAssignIndicator({required int indicatorId}) => "Indicator/$indicatorId/delete-assign";

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

  static String getAllCriterions({required int academicYearId, int? accreditationTypeId, int? departmentId}) {
    final buffer = StringBuffer("Criterion/all?AcademicYearId=$academicYearId");
    if (departmentId != null) buffer.write("&DepartmentId=$departmentId");
    if (accreditationTypeId != null) buffer.write("&AccreditationTypeId=$accreditationTypeId");
    return buffer.toString();
  }

  static String getTemplateCriteria({required int accreditationTypeId}) => "Criterion/templates?AccreditationTypeId=$accreditationTypeId";
  static String toggleCriterionStatus({required int criterionId}) => "Criterion/$criterionId/toggle-status";
}
