import 'package:qualiverse/routing/all_routes_imports.dart';

class UpdateAndCreateAndDeleteFolderModel {
  final String? data;
  final bool isSuccess;
  final ApiErrorModel? error;

  UpdateAndCreateAndDeleteFolderModel({
    this.data,
    required this.isSuccess,
    this.error,
  });

  factory UpdateAndCreateAndDeleteFolderModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return UpdateAndCreateAndDeleteFolderModel(
      data: json['data'],
      isSuccess: json['isSuccess'] ?? false,
      error: json['error'] != null
          ? ApiErrorModel.fromJson(json['error'])
          : null,
    );
  }
}
