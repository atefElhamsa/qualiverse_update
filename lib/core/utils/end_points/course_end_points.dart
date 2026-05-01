part of '../end_points.dart';

mixin CourseEndPoints {
  static const String updateAndCreateCourseFolder = "CourseFolder";
  static const String assignCourse = "Course/assign";
  static const String templates = "Course/templates";
  static const String courseFromTemplate = "Course/from-template";
  static const String newCourse = "Course/new";

  static String courses({required int yearId, required int levelId, required int termId, int? departmentId}) {
    final buffer = StringBuffer("Course?yearId=$yearId&levelId=$levelId&termId=$termId");
    if (departmentId != null) buffer.write("&departmentId=$departmentId");
    return buffer.toString();
  }

  static String getCourseFolders({required int courseId}) => "CourseFolder/$courseId";
  static String deleteCourseFolder({required int folderId}) => "CourseFolder/$folderId";
  static String getFolderFiles({required int folderId}) => "CourseFolder/File?folderId=$folderId";
  static String uploadFileToFolder({required int folderId}) => "CourseFolder/$folderId/upload";
  static String deleteFileFromFolder({required int folderId, required int fileId}) => "CourseFolder/$folderId/files/$fileId";
  static String deleteCourse({required int courseId}) => "Course/$courseId";
  static String removeAssignCourse({required int courseId}) => "Course/$courseId/assign";
  static String coursesByDepartment({required int academicYearId, required int departmentId, required int levelId, required int termId}) => 
    "Course/all?AcademicYearId=$academicYearId&DepartmentId=$departmentId&LevelId=$levelId&TermId=$termId";
}
