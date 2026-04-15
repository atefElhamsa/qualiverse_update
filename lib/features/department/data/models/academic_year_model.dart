import '../../../../core/all_core_imports/all_core_imports.dart';

class YearsResponseModel {
  final List<AcademicYearModel>? data;
  final bool isSuccess;
  final ApiErrorModel? error;

  YearsResponseModel({this.data, required this.isSuccess, this.error});

  factory YearsResponseModel.fromJson(Map<String, dynamic> json) {
    return YearsResponseModel(
      data: (json['data'] as List)
          .map((e) => AcademicYearModel.fromJson(e))
          .toList(),
      isSuccess: json['isSuccess'] ?? false,
      error: json['error'] != null
          ? ApiErrorModel.fromJson(json['error'])
          : null,
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

class AddedYearModel {
  final bool isSuccess;
  final int? yearNumber;
  final ApiErrorModel? error;

  AddedYearModel({required this.isSuccess, this.error, this.yearNumber});

  factory AddedYearModel.fromJson(Map<String, dynamic> json) {
    return AddedYearModel(
      isSuccess: json['isSuccess'] ?? false,
      error: json['error'] != null
          ? ApiErrorModel.fromJson(json['error'])
          : null,
      yearNumber: json['data'],
    );
  }
}
