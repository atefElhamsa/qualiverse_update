import 'package:qualiverse/routing/all_routes_imports.dart';

class EvidenceStatisticsResponse {
  final List<EvidenceStatisticsModel>? data;
  final bool isSuccess;
  final ApiErrorModel? error;

  EvidenceStatisticsResponse({this.data, required this.isSuccess, this.error});

  factory EvidenceStatisticsResponse.fromJson(Map<String, dynamic> json) {
    return EvidenceStatisticsResponse(
      data: json['data'] != null
          ? (json['data'] as List)
              .map(
                (e) => EvidenceStatisticsModel.fromJson(e as Map<String, dynamic>),
              )
              .toList()
          : null,
      isSuccess: json['isSuccess'] ?? false,
      error: json['error'] != null
          ? ApiErrorModel.fromJson(json['error'])
          : null,
    );
  }
}

class EvidenceStatisticsModel {
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
  final int gradeAPlus;
  final int gradeA;
  final int gradeAMinus;
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

  EvidenceStatisticsModel({
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
    this.gradeBPlus,
    this.gradeB,
    this.gradeBMinus,
    this.gradeCPlus,
    this.gradeC,
    this.gradeCMinus,
    this.gradeDPlus,
    this.gradeD,
    this.gradeDMinus,
    this.gradeF,
    required this.courseId,
    required this.evidenceFolderName,
    this.departmentName,
    required this.academicYearNumber,
  });

  factory EvidenceStatisticsModel.fromJson(Map<String, dynamic> json) {
    return EvidenceStatisticsModel(
      id: json['id'] ?? 0,
      courseName: json['courseName'] ?? '',
      totalStudents: json['totalStudents'] ?? 0,
      absent: json['absent'] ?? 0,
      absentWithExcuse: json['absentWithExcuse'] ?? 0,
      deprived: json['deprived'] ?? 0,
      didNotAttendExam: json['didNotAttendExam'] ?? 0,
      attendedExam: json['attendedExam'] ?? 0,
      passedWritten: json['passedWritten'] ?? 0,
      passedWrittenAndYearWork: json['passedWrittenAndYearWork'] ?? 0,
      passPercentageAfterExam: json['passPercentageAfterExam'] ?? '0%',
      gradeAPlus: json['gradeAPlus'] ?? 0,
      gradeA: json['gradeA'] ?? 0,
      gradeAMinus: json['gradeAMinus'] ?? 0,
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
      courseId: json['courseId'] ?? 0,
      evidenceFolderName: json['evidenceFolderName'] ?? '',
      departmentName: json['departmentName'],
      academicYearNumber: json['academicYearNumber'] ?? 0,
    );
  }
}
