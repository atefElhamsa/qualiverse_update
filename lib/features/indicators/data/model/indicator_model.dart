import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class IndicatorResponseModel {
  final bool isSuccess;
  final ApiErrorModel? error;
  final List<IndicatorModel>? data;

  IndicatorResponseModel({required this.isSuccess, this.error, this.data});

  factory IndicatorResponseModel.fromJson(Map<String, dynamic> json) {
    return IndicatorResponseModel(
      isSuccess: json['isSuccess'],
      data: (json['data'] as List)
          .map((e) => IndicatorModel.fromJson(e))
          .toList(),
      error: json['error'] != null
          ? ApiErrorModel.fromJson(json['error'])
          : null,
    );
  }
}

class IndicatorModel {
  final int id;
  final String name;
  final String description;
  final String? fileName;
  final String? filePath;
  final String? fileSize;
  final String? fileType;

  IndicatorModel({
    required this.id,
    required this.name,
    required this.description,
    this.fileName,
    this.filePath,
    this.fileSize,
    this.fileType,
  });

  factory IndicatorModel.fromJson(Map<String, dynamic> json) {
    return IndicatorModel(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      fileName: json['fileName'] as String?,
      filePath: json['filePath'] as String?,
      fileSize: json['fileSize'] as String?,
      fileType: json['fileType'] as String?,
    );
  }
}

extension StandardTitleExt on BuildContext {
  String standardTitle(int index) {
    return tr('standard_${index + 1}');
  }
}
