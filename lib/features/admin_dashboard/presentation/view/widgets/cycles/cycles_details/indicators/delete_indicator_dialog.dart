import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../../../routing/all_routes_imports.dart';

void showDeleteIndicatorDialog({
  required BuildContext context,
  required CycleIndicatorModel cycleIndicator,
}) {
  final cubit = context.read<CycleIndicatorCubit>();

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (dialogContext) {
      return BlocProvider.value(
        value: cubit,
        child: BlocListener<CycleIndicatorCubit, CycleIndicatorState>(
          listener: (ctx, state) {
            if (state is CycleIndicatorActionError) {
              showSnackBar(ctx, state.error, AppColors.red);
            }

            if (state is CycleIndicatorDeleteSuccess) {
              Navigator.of(dialogContext).pop();
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (context.mounted) {
                  showSnackBar(context, state.msg, AppColors.green);
                }
                // ✅ Simple refresh
                cubit.refresh();
              });
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
  final CycleIndicatorCubit cubit;

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
        BlocBuilder<CycleIndicatorCubit, CycleIndicatorState>(
          builder: (context, state) {
            if (state is CycleIndicatorActionLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return DeleteAndCancelButtons(
              onPressed: () {
                cubit.deleteCycleIndicator(indicatorId: cycleIndicator.id);
              },
            );
          },
        ),
      ],
    );
  }
}
