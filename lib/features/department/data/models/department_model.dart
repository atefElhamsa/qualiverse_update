import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class DepartmentModel {
  final int id;
  final String nameAr;
  final String nameEn;

  DepartmentModel({
    required this.id,
    required this.nameAr,
    required this.nameEn,
  });

  factory DepartmentModel.fromJson(Map<String, dynamic> json) {
    return DepartmentModel(
      id: json['id'],
      nameAr: json['nameAr'],
      nameEn: json['nameEn'],
    );
  }
}

extension DepartmentLocaleX on DepartmentModel {
  String localizedName(BuildContext context) {
    return context.locale.languageCode == 'ar' ? nameAr : nameEn;
  }
}
