import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AccreditationType {
  final bool isSuccess;
  final List<TypeModel> types;

  AccreditationType({required this.isSuccess, required this.types});

  factory AccreditationType.fromJson(Map<String, dynamic> json) {
    return AccreditationType(
      types: (json['data'] as List).map((e) => TypeModel.fromJson(e)).toList(),
      isSuccess: json['isSuccess'],
    );
  }
}

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
