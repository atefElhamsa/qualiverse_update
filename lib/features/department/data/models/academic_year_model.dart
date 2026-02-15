class YearsResponseModel {
  final List<AcademicYearModel> data;
  final bool isSuccess;

  YearsResponseModel({required this.data, required this.isSuccess});

  factory YearsResponseModel.fromJson(Map<String, dynamic> json) {
    return YearsResponseModel(
      data: (json['data'] as List)
          .map((e) => AcademicYearModel.fromJson(e))
          .toList(),
      isSuccess: json['isSuccess'] ?? false,
    );
  }
}

class AcademicYearModel {
  final int id;
  final int yearNumber;

  AcademicYearModel({required this.id, required this.yearNumber});

  factory AcademicYearModel.fromJson(Map<String, dynamic> json) {
    return AcademicYearModel(id: json['id'], yearNumber: json['yearNumber']);
  }
}
