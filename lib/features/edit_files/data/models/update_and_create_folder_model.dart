import 'package:qualiverse/routing/all_routes_imports.dart';

class UpdateAndCreateFolderModel {
  final String? data;
  final bool isSuccess;
  final ApiErrorModel? error;

  UpdateAndCreateFolderModel({this.data, required this.isSuccess, this.error});

  factory UpdateAndCreateFolderModel.fromJson(Map<String, dynamic> json) {
    return UpdateAndCreateFolderModel(
      data: json['data'],
      isSuccess: json['isSuccess'] ?? false,
      error: json['error'] != null
          ? ApiErrorModel.fromJson(json['error'])
          : null,
    );
  }
}
