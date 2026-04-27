import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../../../routing/all_routes_imports.dart';

void showRemoveAssignIndicatorDialog({
  required BuildContext context,
  required CycleIndicatorModel cycleIndicator,
}) async {
  final cubit = context.read<AssignCubit>();
  final yearId = AcademicYearCubit.get(context).selectedAcademicYear?.id;
  final departmentId = DepartmentCubit.get(context).selectedDepartment?.id;
  final criterionId =
      ProgramAccreditationCubit.get(context).selectedProgramAccreditation?.id;

  final result = await showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (dialogContext) {
      return BlocProvider.value(
        value: cubit,
        child: BlocListener<AssignCubit, AssignState>(
          listener: (ctx, state) {
            if (state is AssignFailure) {
              showSnackBar(ctx, state.error, AppColors.red);
            }
            if (state is DeleteAssignSuccess) {
              // Pop with true to indicate success
              Navigator.of(dialogContext).pop(true);
            }
          },
          child: RemoveAssignIndicatorDialog(
            cycleIndicator: cycleIndicator,
            cubit: cubit,
          ),
        ),
      );
    },
  );

  // If the result is true, it means removal was successful
  if (result == true) {
    // Show success message on the main screen context
    showSnackBar(context, "doneSuccessfully".tr(), AppColors.green);

    // Refresh the indicators list
    if (yearId != null && departmentId != null && criterionId != null) {
      CycleIndicatorCubit.get(context).fetchCycleIndicators(
        yearId: yearId,
        departmentId: departmentId,
        criterionId: criterionId,
      );
    }
  }
}

class RemoveAssignIndicatorDialog extends StatelessWidget {
  final CycleIndicatorModel cycleIndicator;
  final AssignCubit cubit;

  const RemoveAssignIndicatorDialog({
    super.key,
    required this.cycleIndicator,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.white,
      actionsPadding: EdgeInsets.all(16.h),
      actionsAlignment: MainAxisAlignment.center,
      alignment: Alignment.center,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      title: CustomText(
        title: 'removeAssign'.tr(),
        textAlign: TextAlign.center,
        textStyle: GoogleFonts.inter(
          fontSize: 24.sp,
          fontWeight: FontWeight.w700,
          color: AppColors.red,
        ),
      ),
      content: CustomText(
        title:
            "${"removeAssignMessage".tr()} \"${cycleIndicator.indicatorName}\"?",
        textStyle: Theme.of(
          context,
        ).textTheme.headlineLarge!.copyWith(color: AppColors.mainBlack),
      ),
      actions: [
        BlocBuilder<AssignCubit, AssignState>(
          builder: (context, state) {
            if (state is DeleteAssignLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return DeleteAndCancelButtons(
              onPressed: () {
                cubit.removeAssignIndicator(indicatorId: cycleIndicator.id);
              },
            );
          },
        ),
      ],
    );
  }
}
