import '../../../../core/all_core_imports/all_core_imports.dart';

class DeleteFileIndicatorModel {
  final String? data;
  final bool isSuccess;
  final ApiErrorModel? error;

  const DeleteFileIndicatorModel({
    this.data,
    required this.isSuccess,
    this.error,
  });

  factory DeleteFileIndicatorModel.fromJson(Map<String, dynamic> json) {
    return DeleteFileIndicatorModel(
      data: json['data'],
      isSuccess: json['isSuccess'] ?? false,
      error: json['error'] != null
          ? ApiErrorModel.fromJson(json['error'])
          : null,
    );
  }
}
