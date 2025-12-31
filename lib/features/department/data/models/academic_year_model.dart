class AcademicYearModel {
  final int id;
  final int yearNumber;
  final List<dynamic> criteria;
  final DateTime createdOn;
  final String createdBy;
  final DateTime? lastModifiedOn;
  final String? lastModifiedBy;

  AcademicYearModel({
    required this.id,
    required this.yearNumber,
    required this.criteria,
    required this.createdOn,
    required this.createdBy,
    this.lastModifiedOn,
    this.lastModifiedBy,
  });

  factory AcademicYearModel.fromJson(Map<String, dynamic> json) {
    return AcademicYearModel(
      id: json['id'] as int,
      yearNumber: json['yearNumber'] as int,
      criteria: json['criteria'] as List<dynamic>,
      createdOn: DateTime.parse(json['createdOn']),
      createdBy: json['createdBy'] as String,
      lastModifiedOn: json['lastModifiedOn'] != null
          ? DateTime.parse(json['lastModifiedOn'])
          : null,
      lastModifiedBy: json['lastModifiedBy'],
    );
  }
}
