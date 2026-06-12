import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/features/all_features_imports/all_features_imports.dart';

import '../../../../../../core/all_core_imports/all_core_imports.dart';

class AccountSettingsContent extends StatelessWidget {
  const AccountSettingsContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MeCubit, MeState>(
      listener: (context, state) {
        if (state is MeFailure) {
          showSnackBar(context, state.error, AppColors.red);
        }
      },
      builder: (context, state) {
        if (state is MeLoading) {
          return const Center(child: CustomLoading());
        }
        if (state is MeFailure) {
          return Center(
            child: CustomText(
              title: state.error,
              textStyle: Theme.of(context).textTheme.headlineLarge!,
            ),
          );
        }
        if (state is MeSuccess) {
          final meModel = state.meModel;

          return Padding(
            padding: EdgeInsetsDirectional.only(start: 50.w, end: 80.w, top: 60.h),
            child: ListView(
              padding: const EdgeInsets.all(10),
              physics: const BouncingScrollPhysics(),
              children: [
                CustomText(
                  title: "accountSetting".tr(),
                  textStyle: Theme.of(
                    context,
                  ).textTheme.headlineLarge!.copyWith(
                    fontSize: 32.sp,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 30.h),
                BasicInfoDepartment(meModel: meModel),
                SizedBox(height: 24.h),
                AccountInfoDepartment(meModel: meModel),
              ],
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
