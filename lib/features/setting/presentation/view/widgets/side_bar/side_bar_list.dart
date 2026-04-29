import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../routing/all_routes_imports.dart';
import 'package:easy_localization/easy_localization.dart';

class SideBarList extends StatelessWidget {
  const SideBarList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingCubit, SettingState>(
      builder: (context, state) {
        final settingCubit = SettingCubit.get(context);
        final List<SideItemModel> sidesItem = [
          SideItemModel(
            title: 'account1',
            page: SettingsPage.account,
            selectedPage: settingCubit.selectedPage,
            onTap: () {
              settingCubit.changePage(SettingsPage.account);
            },
          ),
          SideItemModel(
            title: 'notifications1',
            page: SettingsPage.notifications,
            selectedPage: settingCubit.selectedPage,
            onTap: () {
              settingCubit.changePage(SettingsPage.notifications);
            },
          ),
          SideItemModel(
            title: 'language1',
            page: SettingsPage.language,
            selectedPage: settingCubit.selectedPage,
            onTap: () {
              settingCubit.changePage(SettingsPage.language);
            },
          ),
          SideItemModel(
            title: 'help1',
            page: SettingsPage.help,
            selectedPage: settingCubit.selectedPage,
            onTap: () {
              settingCubit.changePage(SettingsPage.help);
            },
          ),
        ];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10.h,
          children: List.generate(
            sidesItem.length,
            (index) => SideItem(sideItemModel: sidesItem[index]),
          ),
        );
      },
    );
  }
}
