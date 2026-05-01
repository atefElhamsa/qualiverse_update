part of '../end_points.dart';

mixin EvidenceEndPoints {
  static const String evidenceFolders = "EvidenceFolder";
  static const String uploadEvidenceGeneral = "EvidenceFolder/upload/general";
  static const String uploadEvidenceStatistics = "EvidenceFolder/upload/statistics";

  static String deleteEvidenceFile({required int id}) => "EvidenceFolder/file/$id";
  static String getEvidenceFilesByFolderId({required int folderId}) => "EvidenceFolder/$folderId";
  static String uploadFileToEvidenceFolder({required int folderId}) => "EvidenceFolder/upload";

  static String getEvidenceFileGeneralFolder({
    required int id,
    int? departmentId,
    required int academicYearId,
    required int termId,
    required int levelId,
    required int courseId,
  }) {
    final buffer = StringBuffer("EvidenceFolder/general?id=$id");
    if (departmentId != null) buffer.write("&departmentId=$departmentId");
    buffer.write("&academicYearId=$academicYearId&termId=$termId&levelId=$levelId&courseId=$courseId");
    return buffer.toString();
  }

  static String getEvidenceStatistics({
    int? departmentId,
    required int academicYearId,
    required int termId,
    required int levelId,
  }) {
    final buffer = StringBuffer("EvidenceFolder/statistics?academicYearId=$academicYearId&termId=$termId&levelId=$levelId");
    if (departmentId != null) buffer.write("&departmentId=$departmentId");
    return buffer.toString();
  }
}
