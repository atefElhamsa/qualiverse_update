import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qualiverse/features/dashboard/presentation/controller/dashboard/dashboard_cubit.dart';
import 'package:qualiverse/features/dashboard/presentation/controller/dashboard/dashboard_state.dart';
import 'package:qualiverse/features/dashboard/data/models/dashboard_response_model.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';

class ThreeContainersRightEvidenceOverview extends StatelessWidget {
  const ThreeContainersRightEvidenceOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardCubit, DashboardState>(
      builder: (context, state) {
        IndicatorOverview? overview;
        if (state is DashboardSuccess) {
          overview = state.data.indicatorOverview;
        }

        final data = [
          {
            "title": "reviewed_evidence",
            "count": overview?.approvedIndicators ?? 0,
          },
          {
            "title": "pending_evidence",
            "count": overview?.pendingIndicators ?? 0,
          },
          {"title": "total_evidence", "count": overview?.totalIndicators ?? 0},
        ];

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(data.length, (index) {
            return Padding(
              padding: EdgeInsets.only(bottom: index == 2 ? 0 : 43.h),
              child: SizedBox(
                width: 214.w,
                height: 72.h,
                child: CustomButton(
                  buttonModel: ButtonModel(
                    onPressed: () {},
                    backgroundColor:
                        Theme.of(context).scaffoldBackgroundColor ==
                                AppColors.white
                            ? AppColors.tableColor
                            : AppColors.mainBlack,
                    radius: 10,
                    customText: CustomText(
                      title: "${data[index]["title"].toString().tr()}\n${data[index]["count"]}",
                      textStyle: GoogleFonts.inter(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w800,
                        color: Theme.of(context).colorScheme.onSecondary,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }
}
