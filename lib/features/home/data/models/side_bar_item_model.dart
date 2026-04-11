import 'package:qualiverse/routing/all_routes_imports.dart';

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
  const SideBarItemModel(
    title: "home",
    image: AppImages.sideBarHomeImage,
    route: AppRoutes.homeScreen,
  ),
  const SideBarItemModel(
    title: "adminDashboard",
    image: AppImages.sideBarAdminDashboardImage,
    route: AppRoutes.adminDashboardScreen,
    isAdmin: true,
  ),
  const SideBarItemModel(
    title: "dashboard",
    image: AppImages.sideBarDashboardImage,
    route: AppRoutes.dashboardScreen,
  ),
  const SideBarItemModel(
    title: "aiModel",
    image: AppImages.sideBarAiImage,
    route: AppRoutes.aiMainScreen,
  ),
  const SideBarItemModel(
    title: "courseFile",
    image: AppImages.sideBarCoursesImage,
    route: AppRoutes.coursesMainScreen,
  ),
  const SideBarItemModel(
    title: "accreditation",
    image: AppImages.sideBarAccreditationImage,
    route: AppRoutes.accreditationScreen,
  ),
  const SideBarItemModel(
    title: "settings",
    image: AppImages.sideBarSettingImage,
    route: AppRoutes.settingScreen,
  ),
];
