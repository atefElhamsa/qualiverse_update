import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AccreditationsResponseModel {
  final List<AccreditationModel> data;
  final bool isSuccess;

  AccreditationsResponseModel({required this.data, required this.isSuccess});

  factory AccreditationsResponseModel.fromJson(Map<String, dynamic> json) {
    return AccreditationsResponseModel(
      data: (json['data'] as List)
          .map((e) => AccreditationModel.fromJson(e))
          .toList(),
      isSuccess: json['isSuccess'] ?? false,
    );
  }
}

class AccreditationModel {
  final int id;
  final String nameAr;
  final String nameEn;

  AccreditationModel({
    required this.id,
    required this.nameAr,
    required this.nameEn,
  });

  factory AccreditationModel.fromJson(Map<String, dynamic> json) {
    return AccreditationModel(
      id: json['id'],
      nameAr: json['nameAr'],
      nameEn: json['nameEn'],
    );
  }
}

extension AccreditationLocaleX on AccreditationModel {
  String localizedName(BuildContext context) {
    return context.locale.languageCode == 'ar' ? nameAr : nameEn;
  }
}
