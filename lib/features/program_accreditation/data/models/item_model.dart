import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';

// Item data model.
class ItemModel {
  final String imageLight;

  final String imageDark;

  final void Function()? onTap;

  ItemModel({required this.imageLight, required this.imageDark, this.onTap});
}

final List<ItemModel> programItems = [
  ItemModel(
    imageLight: AppImages.iconFolder,
    imageDark: AppImages.iconFolderDark,
  ),
  ItemModel(
    imageLight: AppImages.programDesign,
    imageDark: AppImages.programDesignDark,
  ),
  ItemModel(imageLight: AppImages.teaching, imageDark: AppImages.teachingDark),
  ItemModel(imageLight: AppImages.person, imageDark: AppImages.personDark),
  ItemModel(
    imageLight: AppImages.resources,
    imageDark: AppImages.resourcesDark,
  ),
  ItemModel(imageLight: AppImages.star, imageDark: AppImages.starDark),
  ItemModel(imageLight: AppImages.person, imageDark: AppImages.personDark),
];
