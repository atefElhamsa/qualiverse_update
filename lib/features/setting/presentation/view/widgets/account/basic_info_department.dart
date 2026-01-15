import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../routing/all_routes_imports.dart';

class BasicInfoDepartment extends StatelessWidget {
  const BasicInfoDepartment({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 70.h),
          child: CustomText(
            title: "basicInfo".tr(),
            textStyle: Theme.of(context).textTheme.headlineLarge!.copyWith(
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        SizedBox(height: 25),
        ProfileImage(),
        InfoItem(
          label: "name",
          value: "DR . John Doe",
          showChange: true,
          onPressed: () {},
        ),
        InfoItem(label: "gender", value: "Male", showChange: false),
        InfoItem(
          label: "email",
          value: context.read<SettingCubit>().email.toString(),
          showChange: true,
          onPressed: () {},
        ),
      ],
    );
  }
}
