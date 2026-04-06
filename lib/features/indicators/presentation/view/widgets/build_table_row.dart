import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../routing/all_routes_imports.dart';

TableRow buildTableRow({
  required IndicatorModel indicator,
  required BuildContext context,
  required IndicatorsArgs indicatorsArgs,
}) {
  return TableRow(
    decoration: BoxDecoration(
      color: Theme.of(context).scaffoldBackgroundColor == AppColors.white
          ? AppColors.tableColor
          : AppColors.mainBlack,
    ),
    children: [
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Wrap(
          spacing: 6.w,
          runSpacing: 4.h,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            CustomText(
              title: "${indicator.name}:",
              textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.w600,
                color: indicator.filePath == null
                    ? Theme.of(context).colorScheme.onSecondary
                    : AppColors.noFileColor,
              ),
            ),
            CustomText(
              title: indicator.description,
              textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                height: 1.4,
                color: indicator.filePath == null
                    ? Theme.of(context).colorScheme.onSecondary
                    : AppColors.noFileColor,
              ),
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(12.0),
        child: Center(
          child: UploadFileButton(
            indicatorModel: indicator,
            indicatorsArgs: indicatorsArgs,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(12.0),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  if (indicator.filePath == null) {
                    showSnackBar(
                      context,
                      "no_file_uploaded_yet".tr(),
                      Colors.red,
                    );
                  } else {
                    context.read<IndicatorsCubit>().openIndicatorFile(
                      indicator.filePath!,
                    );
                  }
                },
                child: CustomText(
                  title: indicator.fileName ?? "noFile".tr(),
                  textAlign: TextAlign.center,
                  textStyle: TextStyle(
                    color: indicator.filePath == null
                        ? Theme.of(context).colorScheme.onSecondary
                        : AppColors.noFileColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w100,
                  ),
                ),
              ),

              if (indicator.filePath != null)
                IconButton(
                  icon: const Icon(Icons.delete_outline, color: Colors.red),
                  tooltip: "deleteFile".tr(),
                  onPressed: () => showDeleteDialog(
                    context: context,
                    indicator: indicator,
                    indicatorsArgs: indicatorsArgs,
                  ),
                ),
            ],
          ),
        ),
      ),
    ],
  );
}

void showDeleteDialog({
  required BuildContext context,
  required IndicatorModel indicator,
  required IndicatorsArgs indicatorsArgs,
}) {
  showDialog(
    context: context,
    builder: (dialogContext) => BlocProvider.value(
      value: context.read<IndicatorsCubit>(),
      child: BlocListener<IndicatorsCubit, IndicatorsState>(
        listener: (listenerContext, state) {
          if (state is IndicatorsError) {
            showSnackBar(listenerContext, state.message, AppColors.red);
          }
          if (state is FileIndicatorDeleteSuccess) {
            showSnackBar(listenerContext, state.message, AppColors.green);
            Navigator.of(dialogContext).pop();
          }
        },
        child: AlertDialog(
          backgroundColor: AppColors.white,
          actionsPadding: EdgeInsets.all(16.h),
          actionsAlignment: MainAxisAlignment.center,
          alignment: Alignment.center,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          title: CustomText(
            title: 'deleteFile'.tr(),
            textAlign: TextAlign.center,
            textStyle: GoogleFonts.inter(
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.red,
            ),
          ),
          content: CustomText(
            title: "${"deleteFileMessage".tr()} \"${indicator.fileName}\"?",
            textStyle: Theme.of(
              context,
            ).textTheme.headlineLarge!.copyWith(color: AppColors.mainBlack),
          ),
          actions: [
            DeleteAndCancelButtons(
              onPressed: () {
                context.read<IndicatorsCubit>().deleteIndicatorFile(
                  indicatorId: indicator.id,
                  criterionId: indicatorsArgs.accreditationModel.id,
                );
              },
            ),
          ],
        ),
      ),
    ),
  );
}
