import '../../../../core/all_core_imports/all_core_imports.dart';

class ItemFolderModel {
  final String image;

  ItemFolderModel({required this.image});
}

final List<ItemFolderModel> items = [
  ItemFolderModel(image: AppImages.statistics),
  ItemFolderModel(image: AppImages.survey),
  ItemFolderModel(image: AppImages.documentaryAnalysis),
];
