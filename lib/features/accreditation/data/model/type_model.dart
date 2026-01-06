import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class TypeModel {
  final int id;
  final String typeEn;
  final String typeAr;

  TypeModel({required this.id, required this.typeEn, required this.typeAr});

  factory TypeModel.fromJson(Map<String, dynamic> json) {
    return TypeModel(
      id: json['id'],
      typeEn: json['typeEn'],
      typeAr: json['typeAr'],
    );
  }
}

extension AccreditationTypeLocaleX on TypeModel {
  String localizedType(BuildContext context) {
    return context.locale.languageCode == 'ar' ? typeAr : typeEn;
  }
}
