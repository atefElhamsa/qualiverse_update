import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../../routing/all_routes_imports.dart';

class BuildStatisticsAnalysisTab extends StatelessWidget {
  const BuildStatisticsAnalysisTab({
    super.key,
    required this.courseId,
    required this.academicYearId,
    required this.termId,
    required this.levelId,
    required this.departmentId,
    required this.refreshFileData,
  });
  final int courseId;
  final int academicYearId;
  final int termId;
  final int levelId;
  final int? departmentId;
  final Function() refreshFileData;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetFileDataCubit, GetFileDataState>(
      builder: (context, state) {
        if (state is GetFileDataLoading) {
          return const Center(child: CustomLoading());
        }

        if (state is GetFileDataFailure) {
          return SizedBox.expand(
            child: Align(
              alignment: Alignment.center,
              child: RetryWidget(
                title: state.errorMessage,
                onPressed: () => GetFileDataCubit.get(context).getFileData(
                  courseId: courseId,
                  academicYearId: academicYearId,
                  termId: termId,
                  levelId: levelId,
                  departmentId: departmentId,
                ),
              ),
            ),
          );
        }
        if (state is GetFileDataSuccess) {
          if (state.data.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.analytics_outlined,
                    size: 64.sp,
                    color: Colors.grey.shade300,
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    "noDataAvailable".tr(),
                    style: GoogleFonts.almarai(
                      fontSize: 13.sp,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 15.h),
                  TextButton.icon(
                    onPressed: () => refreshFileData(),
                    icon: const Icon(Icons.refresh_rounded),
                    label: Text("refresh".tr()),
                    style: TextButton.styleFrom(
                      foregroundColor: const Color(0xFF0F569E),
                      textStyle: GoogleFonts.almarai(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          return CourseStatisticsDashboard(data: state.data.first);
        }
        return const SizedBox.shrink();
      },
    );
  }
}
