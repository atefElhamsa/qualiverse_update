import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../routing/all_routes_imports.dart';

class LogOutWidget extends StatelessWidget {
  const LogOutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LogoutCubit, LogoutState>(
      listener: (context, state) async {
        if (state is LogoutError) {
          showSnackBar(context, state.error, AppColors.red);
        }
        if (state is LogoutSuccess) {
          showSnackBar(context, state.message, AppColors.green);
          await LoginStorage.clear();
          context.pushReplacementNamed(AppRoutes.splashScreen);
        }
      },
      builder: (context, state) {
        if (state is LogoutLoading) {
          return const CustomLoading();
        }
        return Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: ListTile(
            onTap: () {
              LogoutCubit.get(context).logoutCubit();
            },
            leading: Image.asset(AppImages.logOut, height: 30.h, width: 30.w),
            title: CustomText(
              title: "logOut".tr(),
              textStyle: TextStyle(
                color:
                    Theme.of(context).scaffoldBackgroundColor == AppColors.white
                    ? AppColors.black
                    : AppColors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }
}
