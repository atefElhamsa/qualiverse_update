import 'package:qualiverse/routing/all_routes_imports.dart';

class SideBarItemModel {
  final String title;
  final String image;
  final String? route;

  const SideBarItemModel({
    required this.title,
    required this.image,
    this.route,
  });
}

final List<SideBarItemModel> sideBarItems = [
  const SideBarItemModel(
    title: "home",
    image: AppImages.sideBarImageOne,
    route: AppRoutes.homeScreen,
  ),
  const SideBarItemModel(
    title: "dashboard",
    image: AppImages.sideBarImageTwo,
    route: AppRoutes.dashboardScreen,
  ),
  const SideBarItemModel(
    title: "aiModel",
    image: AppImages.sideBarImageThree,
    route: AppRoutes.aiMainScreen,
  ),
  const SideBarItemModel(
    title: "curricula",
    image: AppImages.sideBarImageFour,
    route: AppRoutes.coursesMainScreen,
  ),
  const SideBarItemModel(
    title: "accreditation",
    image: AppImages.sideBarImageFive,
    route: AppRoutes.accreditationScreen,
  ),
  const SideBarItemModel(
    title: "settings",
    image: AppImages.sideBarImageSix,
    route: AppRoutes.settingScreen,
  ),
];
