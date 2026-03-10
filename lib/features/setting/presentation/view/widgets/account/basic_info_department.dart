import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../routing/all_routes_imports.dart';

class BasicInfoDepartment extends StatelessWidget {
  const BasicInfoDepartment({super.key});

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
          return const CustomLoading();
        }
        if (state is MeSuccess) {
          final meModel = state.meModel;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 70.h),
                child: CustomText(
                  title: "basicInfo".tr(),
                  textStyle: Theme.of(context).textTheme.headlineLarge!
                      .copyWith(fontSize: 24.sp, fontWeight: FontWeight.w700),
                ),
              ),
              const SizedBox(height: 25),
              const ProfileImage(),
              InfoItem(
                label: "name",
                value: "${meModel.firstName} ${meModel.lastName}",
                showChange: true,
                onPressed: () {},
              ),
              const InfoItem(label: "gender", value: "Male", showChange: false),
              InfoItem(
                label: "email",
                value: meModel.email,
                showChange: true,
                onPressed: () {},
              ),
            ],
          );
        }
        return const SizedBox();
      },
    );
  }
}
