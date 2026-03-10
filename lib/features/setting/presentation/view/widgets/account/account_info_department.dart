import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class AccountInfoDepartment extends StatelessWidget {
  const AccountInfoDepartment({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MeCubit, MeState>(
      builder: (context, state) {
        if (state is MeLoading) {
          return const CustomLoading();
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
              const SizedBox(height: 25),
              InfoItem(
                label: "userName",
                value: meModel.userName,
                showChange: false,
              ),
              InfoItem(
                label: "password",
                value: maskPassword(
                  context.read<SettingCubit>().password.toString(),
                ),
                showChange: true,
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
          );
        }
        return const SizedBox();
      },
    );
  }
}
