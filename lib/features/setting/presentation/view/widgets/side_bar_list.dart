import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../routing/all_routes_imports.dart';

class SideBarList extends StatelessWidget {
  const SideBarList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingCubit, SettingState>(
      builder: (context, state) {
        final settingCubit = SettingCubit.get(context);
        final List<SideItemModel> sidesItem = [
          SideItemModel(
            title: 'Account',
            index: 0,
            selectedIndex: settingCubit.selectedIndex,
            onTap: () {
              settingCubit.changeIndex(0);
            },
          ),
          SideItemModel(
            title: 'Notification',
            index: 1,
            selectedIndex: settingCubit.selectedIndex,
            onTap: () {
              settingCubit.changeIndex(1);
            },
          ),
          SideItemModel(
            title: 'Language',
            index: 2,
            selectedIndex: settingCubit.selectedIndex,
            onTap: () {
              settingCubit.changeIndex(2);
            },
          ),
          SideItemModel(
            title: 'Help',
            index: 3,
            selectedIndex: settingCubit.selectedIndex,
            onTap: () {
              settingCubit.changeIndex(3);
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
