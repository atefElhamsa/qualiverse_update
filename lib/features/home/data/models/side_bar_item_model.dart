import 'package:qualiverse/routing/all_routes_imports.dart';
import 'package:easy_localization/easy_localization.dart';

class SideBarItemModel {
  final String title;
  final String image;
  final String? route;
  final bool isAdmin;

  const SideBarItemModel({
    required this.title,
    required this.image,
    this.route,
    this.isAdmin = false,
  });
}

final List<SideBarItemModel> sideBarItems = [
  SideBarItemModel(
    title: "home",
    image: AppImages.sideBarHomeImage,
    route: AppRoutes.homeScreen,
  ),
  SideBarItemModel(
    title: "adminDashboard",
    image: AppImages.sideBarAdminDashboardImage,
    route: AppRoutes.adminDashboardScreen,
    isAdmin: true,
  ),
  SideBarItemModel(
    title: "dashboard",
    image: AppImages.sideBarDashboardImage,
    route: AppRoutes.dashboardScreen,
  ),
  SideBarItemModel(
    title: "aiModel",
    image: AppImages.sideBarAiImage,
    route: AppRoutes.aiMainScreen,
  ),
  SideBarItemModel(
    title: "courseFile",
    image: AppImages.sideBarCoursesImage,
    route: AppRoutes.coursesMainScreen,
  ),
  SideBarItemModel(
    title: "accreditation",
    image: AppImages.sideBarAccreditationImage,
    route: AppRoutes.accreditationScreen,
  ),
  SideBarItemModel(
    title: "settings",
    image: AppImages.sideBarSettingImage,
    route: AppRoutes.settingScreen,
  ),
];
