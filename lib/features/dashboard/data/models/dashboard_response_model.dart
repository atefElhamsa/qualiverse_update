class DashboardResponseModel {
  final DashboardData? data;
  final bool? isSuccess;

  DashboardResponseModel({this.data, this.isSuccess});

  factory DashboardResponseModel.fromJson(Map<String, dynamic> json) {
    return DashboardResponseModel(
      data: json['data'] != null ? DashboardData.fromJson(json['data']) : null,
      isSuccess: json['isSuccess'],
    );
  }
}

class DashboardData {
  final IndicatorOverview? indicatorOverview;
  final AccreditationStructure? accreditationStructure;
  final List<IndicatorUpload>? indicatorUploads;
  final ProgramVsInstitution? programVsInstitution;

  DashboardData({
    this.indicatorOverview,
    this.accreditationStructure,
    this.indicatorUploads,
    this.programVsInstitution,
  });

  factory DashboardData.fromJson(Map<String, dynamic> json) {
    return DashboardData(
      indicatorOverview: json['indicatorOverview'] != null
          ? IndicatorOverview.fromJson(json['indicatorOverview'])
          : null,
      accreditationStructure: json['accreditationStructure'] != null
          ? AccreditationStructure.fromJson(json['accreditationStructure'])
          : null,
      indicatorUploads: (json['indicatorUploads'] as List?)
          ?.map((e) => IndicatorUpload.fromJson(e))
          .toList(),
      programVsInstitution: json['programVsInstitution'] != null
          ? ProgramVsInstitution.fromJson(json['programVsInstitution'])
          : null,
    );
  }
}

class IndicatorOverview {
  final int? totalIndicators;
  final int? approvedIndicators;
  final int? pendingIndicators;
  final int? submittedIndicators;
  final int? rejectedIndicators;
  final List<StatusDistribution>? statusDistribution;
  final List<dynamic>? indicatorsPerCriterion;

  IndicatorOverview({
    this.totalIndicators,
    this.approvedIndicators,
    this.pendingIndicators,
    this.submittedIndicators,
    this.rejectedIndicators,
    this.statusDistribution,
    this.indicatorsPerCriterion,
  });

  factory IndicatorOverview.fromJson(Map<String, dynamic> json) {
    return IndicatorOverview(
      totalIndicators: json['totalIndicators'],
      approvedIndicators: json['approvedIndicators'],
      pendingIndicators: json['pendingIndicators'],
      submittedIndicators: json['submittedIndicators'],
      rejectedIndicators: json['rejectedIndicators'],
      statusDistribution: (json['statusDistribution'] as List?)
          ?.map((e) => StatusDistribution.fromJson(e))
          .toList(),
      indicatorsPerCriterion: json['indicatorsPerCriterion'],
    );
  }
}

class StatusDistribution {
  final String? status;
  final int? count;
  final double? percentage;

  StatusDistribution({this.status, this.count, this.percentage});

  factory StatusDistribution.fromJson(Map<String, dynamic> json) {
    return StatusDistribution(
      status: json['status'],
      count: json['count'],
      percentage: (json['percentage'] as num?)?.toDouble(),
    );
  }
}

class AccreditationStructure {
  final int? totalIndicators;
  final int? totalCriteria;
  final int? totalCourses;
  final List<CoursesPerDepartment>? coursesPerDepartment;
  final List<dynamic>? indicatorsPerCriterion;

  AccreditationStructure({
    this.totalIndicators,
    this.totalCriteria,
    this.totalCourses,
    this.coursesPerDepartment,
    this.indicatorsPerCriterion,
  });

  factory AccreditationStructure.fromJson(Map<String, dynamic> json) {
    return AccreditationStructure(
      totalIndicators: json['totalIndicators'],
      totalCriteria: json['totalCriteria'],
      totalCourses: json['totalCourses'],
      coursesPerDepartment: (json['coursesPerDepartment'] as List?)
          ?.map((e) => CoursesPerDepartment.fromJson(e))
          .toList(),
      indicatorsPerCriterion: json['indicatorsPerCriterion'],
    );
  }
}

class CoursesPerDepartment {
  final String? departmentName;
  final int? count;

  CoursesPerDepartment({this.departmentName, this.count});

  factory CoursesPerDepartment.fromJson(Map<String, dynamic> json) {
    return CoursesPerDepartment(
      departmentName: json['departmentName'],
      count: json['count'],
    );
  }
}

class IndicatorUpload {
  final String? month;
  final int? count;

  IndicatorUpload({this.month, this.count});

  factory IndicatorUpload.fromJson(Map<String, dynamic> json) {
    return IndicatorUpload(
      month: json['month'],
      count: json['count'],
    );
  }
}

class ProgramVsInstitution {
  final List<dynamic>? items;

  ProgramVsInstitution({this.items});

  factory ProgramVsInstitution.fromJson(Map<String, dynamic> json) {
    return ProgramVsInstitution(
      items: json['items'],
    );
  }
}
