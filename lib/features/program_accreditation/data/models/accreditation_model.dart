import '../../../../core/all_core_imports/all_core_imports.dart';

class AccreditationsResponseModel {
  final List<AccreditationModel>? data;
  final bool isSuccess;
  final ApiErrorModel? error;

  AccreditationsResponseModel({this.data, required this.isSuccess, this.error});

  factory AccreditationsResponseModel.fromJson(Map<String, dynamic> json) {
    return AccreditationsResponseModel(
      data: (json['data'] as List)
          .map((e) => AccreditationModel.fromJson(e))
          .toList(),
      isSuccess: json['isSuccess'] ?? false,
      error: json['error'] != null
          ? ApiErrorModel.fromJson(json['error'])
          : null,
    );
  }
}

class AccreditationModel {
  final int id;
  final String name;

  AccreditationModel({required this.id, required this.name});

  factory AccreditationModel.fromJson(Map<String, dynamic> json) {
    return AccreditationModel(id: json['id'], name: json['name']);
  }
}
