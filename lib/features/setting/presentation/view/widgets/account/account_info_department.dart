import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class AccountInfoDepartment extends StatelessWidget {
  final MeModel meModel;
  const AccountInfoDepartment({super.key, required this.meModel});

  @override
  Widget build(BuildContext context) {
    final isLight =
        Theme.of(context).scaffoldBackgroundColor == AppColors.white;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          title: "account_info".tr(),
          textStyle: Theme.of(context).textTheme.headlineLarge!.copyWith(
            fontSize: 24.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 20),
        Container(
          decoration: BoxDecoration(
            color: isLight
                ? Colors.white
                : AppColors.textFieldDark.withOpacity(0.2),
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: isLight
                  ? AppColors.grey.withOpacity(0.35)
                  : AppColors.textFieldDark,
              width: 1,
            ),
            boxShadow: isLight
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.02),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          padding: EdgeInsets.all(16.r),
          child: Column(
            children: [
              InfoItem(
                label: "userName".tr(),
                value: meModel.userName,
                showChange: false,
                icon: Icons.account_circle_outlined,
              ),
              Divider(
                height: 1,
                color: isLight
                    ? AppColors.grey.withOpacity(0.25)
                    : AppColors.textFieldDark.withOpacity(0.5),
              ),
              InfoItem(
                label: "password".tr(),
                value: maskPassword(
                  context.read<SettingCubit>().password.toString(),
                ),
                showChange: true,
                icon: Icons.lock_outline_rounded,
                onPressed: () {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) {
                      return BlocProvider.value(
                        value: context.read<ChangePasswordCubit>(),
                        child: const ChangePasswordDialog(),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
