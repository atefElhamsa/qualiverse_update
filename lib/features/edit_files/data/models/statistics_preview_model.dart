import 'package:qualiverse/routing/all_routes_imports.dart';

class StatisticsPreviewResponse {
  final StatisticsPreviewData? data;
  final bool isSuccess;
  final ApiErrorModel? error;

  StatisticsPreviewResponse({this.data, required this.isSuccess, this.error});

  factory StatisticsPreviewResponse.fromJson(Map<String, dynamic> json) {
    return StatisticsPreviewResponse(
      data: json['data'] != null ? StatisticsPreviewData.fromJson(json['data']) : null,
      isSuccess: json['isSuccess'] ?? false,
      error: json['error'] != null ? ApiErrorModel.fromJson(json['error']) : null,
    );
  }
}

class StatisticsPreviewData {
  final String previewId;
  final List<StatisticsPreviewRow> rows;
  final int matchedCount;
  final int unmatchedCount;

  StatisticsPreviewData({
    required this.previewId,
    required this.rows,
    required this.matchedCount,
    required this.unmatchedCount,
  });

  factory StatisticsPreviewData.fromJson(Map<String, dynamic> json) {
    return StatisticsPreviewData(
      previewId: json['previewId'] ?? '',
      rows: json['rows'] != null
          ? (json['rows'] as List).map((e) => StatisticsPreviewRow.fromJson(e)).toList()
          : [],
      matchedCount: json['matchedCount'] ?? 0,
      unmatchedCount: json['unmatchedCount'] ?? 0,
    );
  }
}

class StatisticsPreviewRow {
  final int rowIndex;
  final String fileCourseName;
  final int? matchedCourseId;
  final String? matchedCourseName;
  final int matchScore;
  final String matchType;
  final int totalStudents;
  final int absent;
  final int absentWithExcuse;
  final int deprived;
  final int didNotAttendExam;
  final int attendedExam;
  final String passPercentageAfterExam;

  StatisticsPreviewRow({
    required this.rowIndex,
    required this.fileCourseName,
    this.matchedCourseId,
    this.matchedCourseName,
    required this.matchScore,
    required this.matchType,
    required this.totalStudents,
    required this.absent,
    required this.absentWithExcuse,
    required this.deprived,
    required this.didNotAttendExam,
    required this.attendedExam,
    required this.passPercentageAfterExam,
  });

  factory StatisticsPreviewRow.fromJson(Map<String, dynamic> json) {
    return StatisticsPreviewRow(
      rowIndex: json['rowIndex'] ?? 0,
      fileCourseName: json['fileCourseName'] ?? '',
      matchedCourseId: json['matchedCourseId'],
      matchedCourseName: json['matchedCourseName'],
      matchScore: json['matchScore'] ?? 0,
      matchType: json['matchType'] ?? '',
      totalStudents: json['totalStudents'] ?? 0,
      absent: json['absent'] ?? 0,
      absentWithExcuse: json['absentWithExcuse'] ?? 0,
      deprived: json['deprived'] ?? 0,
      didNotAttendExam: json['didNotAttendExam'] ?? 0,
      attendedExam: json['attendedExam'] ?? 0,
      passPercentageAfterExam: json['passPercentageAfterExam'] ?? '',
    );
  }
}
