import 'package:qualiverse/routing/all_routes_imports.dart';

class GetFileDataResponseModel {
  final List<GetFileDataModel>? data;
  final bool isSuccess;
  final ApiErrorModel? error;

  GetFileDataResponseModel({this.data, required this.isSuccess, this.error});

  factory GetFileDataResponseModel.fromJson(Map<String, dynamic> json) {
    return GetFileDataResponseModel(
      data: json['data'] != null
          ? (json['data'] as List)
                .map((item) => GetFileDataModel.fromJson(item))
                .toList()
          : [],
      isSuccess: json['isSuccess'],
      error: json['error'] != null
          ? ApiErrorModel.fromJson(json['error'])
          : null,
    );
  }
}

class GetFileDataModel {
  final int id;
  final String courseName;
  final int totalStudents;
  final int absent;
  final int absentWithExcuse;
  final int deprived;
  final int didNotAttendExam;
  final int attendedExam;
  final int passedWritten;
  final int passedWrittenAndYearWork;
  final String passPercentageAfterExam;
  final int? gradeAPlus;
  final int? gradeA;
  final int? gradeAMinus;
  final int? gradeBPlus;
  final int? gradeB;
  final int? gradeBMinus;
  final int? gradeCPlus;
  final int? gradeC;
  final int? gradeCMinus;
  final int? gradeDPlus;
  final int? gradeD;
  final int? gradeDMinus;
  final int? gradeF;
  final int courseId;
  final String evidenceFolderName;
  final String? departmentName;
  final int academicYearNumber;

  GetFileDataModel({
    required this.id,
    required this.courseName,
    required this.totalStudents,
    required this.absent,
    required this.absentWithExcuse,
    required this.deprived,
    required this.didNotAttendExam,
    required this.attendedExam,
    required this.passedWritten,
    required this.passedWrittenAndYearWork,
    required this.passPercentageAfterExam,
    required this.gradeAPlus,
    required this.gradeA,
    required this.gradeAMinus,
    required this.gradeBPlus,
    required this.gradeB,
    required this.gradeBMinus,
    required this.gradeCPlus,
    required this.gradeC,
    required this.gradeCMinus,
    required this.gradeDPlus,
    required this.gradeD,
    required this.gradeDMinus,
    required this.gradeF,
    required this.courseId,
    required this.evidenceFolderName,
    this.departmentName,
    required this.academicYearNumber,
  });

  factory GetFileDataModel.fromJson(Map<String, dynamic> json) {
    return GetFileDataModel(
      id: json['id'],
      courseName: json['courseName'],
      totalStudents: json['totalStudents'],
      absent: json['absent'],
      absentWithExcuse: json['absentWithExcuse'],
      deprived: json['deprived'],
      didNotAttendExam: json['didNotAttendExam'],
      attendedExam: json['attendedExam'],
      passedWritten: json['passedWritten'],
      passedWrittenAndYearWork: json['passedWrittenAndYearWork'],
      passPercentageAfterExam: json['passPercentageAfterExam'],
      gradeAPlus: json['gradeAPlus'],
      gradeA: json['gradeA'],
      gradeAMinus: json['gradeAMinus'],
      gradeBPlus: json['gradeBPlus'],
      gradeB: json['gradeB'],
      gradeBMinus: json['gradeBMinus'],
      gradeCPlus: json['gradeCPlus'],
      gradeC: json['gradeC'],
      gradeCMinus: json['gradeCMinus'],
      gradeDPlus: json['gradeDPlus'],
      gradeD: json['gradeD'],
      gradeDMinus: json['gradeDMinus'],
      gradeF: json['gradeF'],
      courseId: json['courseId'],
      evidenceFolderName: json['evidenceFolderName'],
      departmentName: json['departmentName'],
      academicYearNumber: json['academicYearNumber'],
    );
  }
}
