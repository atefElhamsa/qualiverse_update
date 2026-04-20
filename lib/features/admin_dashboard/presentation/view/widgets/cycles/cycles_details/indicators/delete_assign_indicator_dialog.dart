import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../../../routing/all_routes_imports.dart';

void showAssignDeleteDialog({
  required BuildContext context,
  required CycleIndicatorModel cycleIndicator,
}) {
  final cubit = context.read<AssignCubit>();

  showDialog(
    context: context,
    builder: (dialogContext) {
      return BlocProvider.value(
        value: cubit,
        child: BlocListener<AssignCubit, AssignState>(
          listener: (ctx, state) {
            if (state is AssignFailure) {
              showSnackBar(ctx, state.error, AppColors.red);
            }

            if (state is DeleteAssignSuccess) {
              showSnackBar(ctx, state.message, AppColors.green);
              Navigator.of(dialogContext).pop();
              CycleIndicatorCubit.get(context).fetchCycleIndicators(
                yearId: AcademicYearCubit.get(context).selectedAcademicYear!.id,
                departmentId: DepartmentCubit.get(
                  context,
                ).selectedDepartment!.id,
                criterionId: ProgramAccreditationCubit.get(
                  context,
                ).selectedProgramAccreditation!.id,
              );
            }
          },
          child: DeleteIndicatorDialog(
            cycleIndicator: cycleIndicator,
            cubit: cubit,
          ),
        ),
      );
    },
  );
}

class DeleteIndicatorDialog extends StatelessWidget {
  final CycleIndicatorModel cycleIndicator;
  final AssignCubit cubit;

  const DeleteIndicatorDialog({
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
        title: 'deleteIndicator'.tr(),
        textAlign: TextAlign.center,
        textStyle: GoogleFonts.inter(
          fontSize: 24.sp,
          fontWeight: FontWeight.w700,
          color: AppColors.red,
        ),
      ),
      content: CustomText(
        title:
            "${"deleteFileMessage".tr()} \"${cycleIndicator.indicatorName}\"?",
        textStyle: Theme.of(
          context,
        ).textTheme.headlineLarge!.copyWith(color: AppColors.mainBlack),
      ),
      actions: [
        DeleteAndCancelButtons(
          onPressed: () {
            cubit.removeAssign(indicatorId: cycleIndicator.id);
          },
        ),
      ],
    );
  }
}
