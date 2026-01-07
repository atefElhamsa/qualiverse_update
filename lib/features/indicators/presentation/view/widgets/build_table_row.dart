import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../routing/all_routes_imports.dart';

TableRow buildTableRow({
  required IndicatorModel indicator,
  required BuildContext context,
  required IndicatorsArgs indicatorsArgs,
}) {
  return TableRow(
    decoration: const BoxDecoration(color: AppColors.tableColor),
    children: [
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Wrap(
          spacing: 6.w,
          runSpacing: 4.h,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            CustomText(
              title: "${indicator.localizedName(context)}:",
              textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.w600,
                color: indicator.filePath == null
                    ? AppColors.mainBlack
                    : AppColors.noFileColor,
              ),
            ),
            CustomText(
              title: indicator.localizedDescription(context),
              textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                height: 1.4,
                color: indicator.filePath == null
                    ? AppColors.mainBlack
                    : AppColors.noFileColor,
              ),
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(12.0),
        child: Center(
          child: UploadFileButtom(
            indicatorModel: indicator,
            indicatorsArgs: indicatorsArgs,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(12.0),
        child: Center(
          child: TextButton(
            onPressed: () {
              if (indicator.filePath == null) {
                showSnackBar(context, "no_file_uploaded_yet".tr(), Colors.red);
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
                    ? AppColors.mainBlack
                    : AppColors.noFileColor,
                fontSize: 20,
                fontWeight: FontWeight.w100,
              ),
            ),
          ),
        ),
      ),
    ],
  );
}
