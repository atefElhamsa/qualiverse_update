import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../routing/all_routes_imports.dart';

class NoEmptyIndicatorsList extends StatelessWidget {
  const NoEmptyIndicatorsList({super.key, required this.indicators});
  final List<IndicatorModel> indicators;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Table(
        border: TableBorder.all(color: Colors.transparent),
        columnWidths: {
          0: FixedColumnWidth(450.w),
          1: FixedColumnWidth(300.w),
          2: FixedColumnWidth(450.w),
        },
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: [
          tableHeader(context),
          tableSpaceBottomHeader(),
          for (final indicator in indicators) ...[
            TableRow(
              decoration: const BoxDecoration(color: AppColors.tableColor),
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 12.h,
                  ),
                  child: Wrap(
                    spacing: 6.w,
                    runSpacing: 4.h,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      CustomText(
                        title: "${indicator.localizedName(context)}:",
                        textStyle: Theme.of(context).textTheme.bodyMedium!
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                      CustomText(
                        title: indicator.localizedDescription(context),
                        textStyle: Theme.of(
                          context,
                        ).textTheme.bodySmall!.copyWith(height: 1.4),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Center(child: UploadFileButtom()),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Center(
                    child: CustomText(
                      title: indicator.filePath == null
                          ? "noFile".tr()
                          : indicator.filePath!,
                      textStyle: TextStyle(
                        color: indicator.filePath == null
                            ? AppColors.mainBlack
                            : AppColors.noFileColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
            tableSpaceBottomHeader(),
          ],
        ],
      ),
    );
  }
}
