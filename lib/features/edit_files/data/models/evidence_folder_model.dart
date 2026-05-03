import 'package:qualiverse/routing/all_routes_imports.dart';

class EvidenceFolderResponseModel {
  final List<EvidenceFolderModel>? courseFolders;
  final bool isSuccess;
  final ApiErrorModel? error;

  EvidenceFolderResponseModel({
    this.courseFolders,
    required this.isSuccess,
    this.error,
  });

  factory EvidenceFolderResponseModel.fromJson(Map<String, dynamic> json) {
    return EvidenceFolderResponseModel(
      courseFolders: json['data'] != null
          ? List<EvidenceFolderModel>.from(
              json['data'].map((x) => EvidenceFolderModel.fromJson(x)),
            )
          : null,
      isSuccess: json['isSuccess'] ?? false,
      error: json['error'] != null
          ? ApiErrorModel.fromJson(json['error'])
          : null,
    );
  }
}

class EvidenceFolderModel {
  final int id;
  final String name;
  final String nameAr;
  final String nameEn;
  final String description;

  EvidenceFolderModel({
    required this.id,
    required this.name,
    required this.nameAr,
    required this.nameEn,
    required this.description,
  });

  factory EvidenceFolderModel.fromJson(Map<String, dynamic> json) {
    String ar = "";
    String en = "";

    if (json['translations'] != null && json['translations'] is List) {
      for (var translation in json['translations']) {
        if (translation['languageCode'] == 'ar') {
          ar = translation['name'] ?? "";
        } else if (translation['languageCode'] == 'en') {
          en = translation['name'] ?? "";
        }
      }
    }

    return EvidenceFolderModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      nameAr: ar,
      nameEn: en,
      description: json['description'] ?? '',
    );
  }
}
