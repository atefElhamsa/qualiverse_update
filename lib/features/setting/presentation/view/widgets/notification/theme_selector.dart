import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../routing/all_routes_imports.dart';

class ThemeSelector extends StatelessWidget {
  const ThemeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingCubit, SettingState>(
      builder: (context, state) {
        final settingCubit = SettingCubit.get(context);
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CustomText(
              title: "theme".tr(),
              textStyle: Theme.of(
                context,
              ).textTheme.headlineLarge!.copyWith(fontSize: 16.sp),
            ),
            SizedBox(width: 200.w),
            PopupMenuButton<String>(
              tooltip: '',
              color: AppColors.customContainerSettingColor,
              offset: const Offset(0, 36),
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.r),
              ),
              onSelected: (value) {
                settingCubit.changeTheme(dark: value == 'dark');
              },
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 'light',
                  child: CustomText(
                    title: 'light'.tr(),
                    textStyle: Theme.of(
                      context,
                    ).textTheme.headlineLarge!.copyWith(fontSize: 16.sp),
                  ),
                ),
                PopupMenuItem(
                  value: 'dark',
                  child: CustomText(
                    title: 'dark'.tr(),
                    textStyle: Theme.of(
                      context,
                    ).textTheme.headlineLarge!.copyWith(fontSize: 16.sp),
                  ),
                ),
              ],
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomText(
                    title: settingCubit.isDark ? 'dark'.tr() : 'light'.tr(),
                    textStyle: Theme.of(
                      context,
                    ).textTheme.headlineLarge!.copyWith(fontSize: 16.sp),
                  ),
                  SizedBox(width: 4.w),
                  Icon(Icons.keyboard_arrow_down, size: 24.sp),
                ],
              ),
            ),
            SizedBox(width: 20.w),
            Container(
              height: 55.h,
              width: 55.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.drColor,
              ),
              child: Center(
                child: IconButton(
                  onPressed: () {
                    settingCubit.changeTheme(dark: !settingCubit.isDark);
                  },
                  icon: Icon(
                    settingCubit.isDark ? Icons.wb_sunny : Icons.nights_stay,
                    size: 30.sp,
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
