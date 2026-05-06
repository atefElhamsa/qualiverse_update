import '../../../../core/all_core_imports/all_core_imports.dart';

class DashboardTotalsResponseModel {
  final DashboardTotalsModel? data;
  final bool isSuccess;
  final ApiErrorModel? error;

  DashboardTotalsResponseModel({
    this.data,
    required this.isSuccess,
    this.error,
  });

  factory DashboardTotalsResponseModel.fromJson(Map<String, dynamic> json) {
    return DashboardTotalsResponseModel(
      data: json['data'] != null
          ? DashboardTotalsModel.fromJson(json['data'])
          : null,
      isSuccess: json['isSuccess'] ?? false,
      error: json['error'] != null
          ? ApiErrorModel.fromJson(json['error'])
          : null,
    );
  }
}

class DashboardTotalsModel {
  final int totalCourses;
  final int totalIndicators;
  final int programmaticIndicators;
  final int institutionalIndicators;
  final int totalFiles;
  final int totalUsers;

  DashboardTotalsModel({
    required this.totalCourses,
    required this.totalIndicators,
    required this.programmaticIndicators,
    required this.institutionalIndicators,
    required this.totalFiles,
    required this.totalUsers,
  });

  factory DashboardTotalsModel.fromJson(Map<String, dynamic> json) {
    return DashboardTotalsModel(
      totalCourses: json['totalCourses'] ?? 0,
      totalIndicators: json['totalIndicators'] ?? 0,
      programmaticIndicators: json['programmaticIndicators'] ?? 0,
      institutionalIndicators: json['institutionalIndicators'] ?? 0,
      totalFiles: json['totalFiles'] ?? 0,
      totalUsers: json['totalUsers'] ?? 0,
    );
  }
}

class DepartmentProgressResponseModel {
  final List<DepartmentProgressModel>? data;
  final bool isSuccess;
  final ApiErrorModel? error;

  DepartmentProgressResponseModel({
    this.data,
    required this.isSuccess,
    this.error,
  });

  factory DepartmentProgressResponseModel.fromJson(Map<String, dynamic> json) {
    return DepartmentProgressResponseModel(
      data: json['data'] != null
          ? (json['data'] as List)
              .map((e) => DepartmentProgressModel.fromJson(e))
              .toList()
          : null,
      isSuccess: json['isSuccess'] ?? false,
      error: json['error'] != null
          ? ApiErrorModel.fromJson(json['error'])
          : null,
    );
  }
}

class DepartmentProgressModel {
  final int departmentId;
  final String departmentName;
  final int totalIndicators;
  final int indicatorsWithFiles;
  final int indicatorsPercentage;
  final int totalCourses;
  final int coursesWithFiles;
  final int coursesPercentage;
  final int overallPercentage;

  DepartmentProgressModel({
    required this.departmentId,
    required this.departmentName,
    required this.totalIndicators,
    required this.indicatorsWithFiles,
    required this.indicatorsPercentage,
    required this.totalCourses,
    required this.coursesWithFiles,
    required this.coursesPercentage,
    required this.overallPercentage,
  });

  factory DepartmentProgressModel.fromJson(Map<String, dynamic> json) {
    return DepartmentProgressModel(
      departmentId: json['departmentId'] ?? 0,
      departmentName: json['departmentName'] ?? '',
      totalIndicators: json['totalIndicators'] ?? 0,
      indicatorsWithFiles: json['indicatorsWithFiles'] ?? 0,
      indicatorsPercentage: json['indicatorsPercentage'] ?? 0,
      totalCourses: json['totalCourses'] ?? 0,
      coursesWithFiles: json['coursesWithFiles'] ?? 0,
      coursesPercentage: json['coursesPercentage'] ?? 0,
      overallPercentage: json['overallPercentage'] ?? 0,
    );
  }
}

class InstitutionalProgressResponseModel {
  final InstitutionalProgressModel? data;
  final bool isSuccess;
  final ApiErrorModel? error;

  InstitutionalProgressResponseModel({
    this.data,
    required this.isSuccess,
    this.error,
  });

  factory InstitutionalProgressResponseModel.fromJson(Map<String, dynamic> json) {
    return InstitutionalProgressResponseModel(
      data: json['data'] != null
          ? InstitutionalProgressModel.fromJson(json['data'])
          : null,
      isSuccess: json['isSuccess'] ?? false,
      error: json['error'] != null
          ? ApiErrorModel.fromJson(json['error'])
          : null,
    );
  }
}

class InstitutionalProgressModel {
  final int totalIndicators;
  final int indicatorsWithFiles;
  final int percentage;

  InstitutionalProgressModel({
    required this.totalIndicators,
    required this.indicatorsWithFiles,
    required this.percentage,
  });

  factory InstitutionalProgressModel.fromJson(Map<String, dynamic> json) {
    return InstitutionalProgressModel(
      totalIndicators: json['totalIndicators'] ?? 0,
      indicatorsWithFiles: json['indicatorsWithFiles'] ?? 0,
      percentage: json['percentage'] ?? 0,
    );
  }
}
