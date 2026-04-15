import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../routing/all_routes_imports.dart';

class CreateCycleButton extends StatelessWidget {
  const CreateCycleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AcademicYearCubit, AcademicYearState>(
      listener: (context, state) {
        if (state is AcademicYearAddedError) {
          showSnackBar(context, state.message, AppColors.red);
        }
        if (state is AcademicYearAdded) {
          showSnackBar(context, 'Cycle created successfully', AppColors.green);
          BlocProvider.of<AcademicYearCubit>(context).fetchAcademicYears();
        }
      },
      child: Align(
        alignment: AlignmentDirectional.centerEnd,
        child: FilledButton.icon(
          onPressed: () {
            onNewCycle(context, BlocProvider.of<AcademicYearCubit>(context));
          },
          style: FilledButton.styleFrom(
            backgroundColor: AppColors.blue,
            foregroundColor: AppColors.white,
            padding: const EdgeInsets.all(5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.r),
            ),
          ),
          icon: const Icon(Icons.add, size: 25),
          label: CustomText(
            title: 'New Cycle',
            textStyle: Theme.of(
              context,
            ).textTheme.headlineLarge!.copyWith(color: AppColors.white),
          ),
        ),
      ),
    );
  }
}
