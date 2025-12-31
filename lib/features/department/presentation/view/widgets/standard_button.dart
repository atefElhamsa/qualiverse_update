import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class StandardButton extends StatelessWidget {
  const StandardButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 70.h,
        width: 225.w,
        // Display a custom button.
        child: CustomButton(
          buttonModel: ButtonModel(
            onPressed: () {
              final department = DepartmentCubit.get(
                context,
              ).selectedDepartment;
              final academicYear = AcademicYearCubit.get(
                context,
              ).selectedAcademicYear;
              if (department == null || academicYear == null) {
                showSnackBar(
                  context,
                  "pleaseSelectedYearAndDepartment".tr(),
                  AppColors.red,
                );
              } else {
                context.pushNamed(
                  AppRoutes.programAccreditationScreen,
                  extra: {
                    'academicYearId': academicYear.id,
                    'departmentId': department.id,
                  },
                );
              }
            },
            // Set the button's background color.
            backgroundColor: Theme.of(context).colorScheme.onSecondaryContainer,
            // Set the button's corner radius.
            radius: 20,
            customText: CustomText(
              title: "standards".tr(),
              textStyle: Theme.of(context).textTheme.headlineMedium!,
            ),
          ),
        ),
      ),
    );
  }
}
