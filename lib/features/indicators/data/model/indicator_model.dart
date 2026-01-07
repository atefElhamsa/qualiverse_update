import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class IndicatorModel {
  final int id;
  final String nameAr;
  final String nameEn;
  final String descriptionAr;
  final String descriptionEn;
  final String? filePath;
  final String? fileName;

  IndicatorModel({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    required this.descriptionAr,
    required this.descriptionEn,
    required this.filePath,
    required this.fileName,
  });

  factory IndicatorModel.fromJson(Map<String, dynamic> json) {
    return IndicatorModel(
      id: json['id'],
      nameAr: json['nameAr'],
      nameEn: json['nameEn'],
      descriptionAr: json['descriptionAr'],
      descriptionEn: json['descriptionEn'],
      filePath: json['filePath'],
      fileName: json['fileName'],
    );
  }
}

extension IndicatorLocaleX on IndicatorModel {
  String localizedName(BuildContext context) {
    return context.locale.languageCode == 'ar' ? nameAr : nameEn;
  }

  String localizedDescription(BuildContext context) {
    return context.locale.languageCode == 'ar' ? descriptionAr : descriptionEn;
  }
}

extension StandardTitleExt on BuildContext {
  String standardTitle(int index) {
    return tr('standard_${index + 1}');
  }
}
