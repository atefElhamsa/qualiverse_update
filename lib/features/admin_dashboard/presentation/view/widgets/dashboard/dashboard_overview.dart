import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../../../../routing/all_routes_imports.dart';

class DashboardOverview extends StatefulWidget {
  const DashboardOverview({super.key});

  @override
  State<DashboardOverview> createState() => _DashboardOverviewState();
}

class _DashboardOverviewState extends State<DashboardOverview> {
  Locale? _currentLocale;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final yearCubit = AcademicYearCubit.get(context);
      if (yearCubit.selectedAcademicYear != null) {
        DashboardOverviewCubit.get(
          context,
        ).getAllDashboardData(yearId: yearCubit.selectedAcademicYear!.id);
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final newLocale = context.locale;
    if (_currentLocale != null && _currentLocale != newLocale) {
      final yearCubit = AcademicYearCubit.get(context);
      if (yearCubit.selectedAcademicYear != null) {
        DashboardOverviewCubit.get(
          context,
        ).getAllDashboardData(yearId: yearCubit.selectedAcademicYear!.id);
      }
    }
    _currentLocale = newLocale;
  }

  @override
  Widget build(BuildContext context) {
    final yearCubit = context.watch<AcademicYearCubit>();
    if (yearCubit.selectedAcademicYear == null) {
      return SizedBox(
        height: 500.h,
        child: Center(
          child: CustomText(
            title: 'noAcademicYears'.tr(),
            textStyle: TextStyle(
              fontSize: 18.sp,
              color: AppColors.textGrey,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }

    return BlocListener<AcademicYearCubit, AcademicYearState>(
      listener: (context, state) {
        if (state is AcademicYearSuccess &&
            state.selectedAcademicYear != null) {
          DashboardOverviewCubit.get(
            context,
          ).getAllDashboardData(yearId: state.selectedAcademicYear!.id);
        }
      },
      child: BlocBuilder<DashboardOverviewCubit, DashboardOverviewState>(
        builder: (context, state) {
          if (state is DashboardOverviewLoading ||
              state is DashboardOverviewInitial) {
            return const AdminDashboardShimmer();
          }

          if (state is DashboardOverviewError) {
            return SizedBox(
              height: 500.h,
              child: Center(
                child: RetryWidget(
                  title: state.message,
                  onPressed: () {
                    final yearCubit = AcademicYearCubit.get(context);
                    if (yearCubit.selectedAcademicYear != null) {
                      DashboardOverviewCubit.get(context).getAllDashboardData(
                        yearId: yearCubit.selectedAcademicYear!.id,
                      );
                    }
                  },
                ),
              ),
            );
          }

          if (state is DashboardOverviewSuccess) {
            final totals = state.totals;
            final institutionalProgress = state.institutionalProgress;
            final departmentProgress = state.departmentProgress;

            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10.h),
                  // Top Summary Cards
                  IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: DashboardSummaryCard(
                            title: 'totalCourses'.tr(),
                            value: totals.totalCourses.toString(),
                            subtitle: 'allLevels'.tr(),
                            icon: PhosphorIcons.student(),
                            iconColor: AppColors.blue,
                            iconBgColor: AppColors.blue.withOpacity(0.1),
                            delay: 0,
                          ),
                        ),
                        SizedBox(width: 16.w),
                        Expanded(
                          child: DashboardSummaryCard(
                            title: 'totalIndicators'.tr(),
                            value: totals.totalIndicators.toString(),
                            subtitle: '',
                            icon: PhosphorIcons.target(),
                            iconColor: AppColors.green,
                            iconBgColor: AppColors.green.withOpacity(0.1),
                            delay: 100,
                            footer: FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: AlignmentDirectional.centerStart,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  DashboardMiniBadge(
                                    icon: PhosphorIcons.monitor(),
                                    value: totals.programmaticIndicators
                                        .toString(),
                                    label: 'programmatic'.tr(),
                                    color: AppColors.green,
                                    total: totals.totalIndicators,
                                  ),
                                  SizedBox(width: 8.w),
                                  DashboardMiniBadge(
                                    icon: PhosphorIcons.bank(),
                                    value: totals.institutionalIndicators
                                        .toString(),
                                    label: 'institutional'.tr(),
                                    color: AppColors.blue,
                                    total: totals.totalIndicators,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 16.w),
                        Expanded(
                          child: DashboardSummaryCard(
                            title: 'totalFilesUploaded'.tr(),
                            value: totals.totalFiles.toString(),
                            subtitle: 'allTypes'.tr(),
                            icon: PhosphorIcons.fileText(),
                            iconColor: Colors.deepPurple,
                            iconBgColor: Colors.deepPurple.withOpacity(0.1),
                            delay: 200,
                          ),
                        ),
                        SizedBox(width: 16.w),
                        Expanded(
                          child: DashboardSummaryCard(
                            title: 'totalUsers'.tr(),
                            value: totals.totalUsers.toString(),
                            subtitle: 'activeUsers'.tr(),
                            icon: PhosphorIcons.users(),
                            iconColor: AppColors.orange,
                            iconBgColor: AppColors.orange.withOpacity(0.1),
                            delay: 300,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.h),
                  // Department Bar Chart
                  DashboardBarChartCard(
                    title: 'departmentProgress'.tr(),
                    data: departmentProgress
                        .map(
                          (e) => DepartmentBarData(
                            department: e.departmentName,
                            indicators: e.indicatorsPercentage.toDouble(),
                            indicatorsCount: e.indicatorsWithFiles,
                            indicatorsTotal: e.totalIndicators,
                            courses: e.coursesPercentage.toDouble(),
                            coursesCount: e.coursesWithFiles,
                            coursesTotal: e.totalCourses,
                            overall: e.overallPercentage.toDouble(),
                          ),
                        )
                        .toList(),
                  ),
                  SizedBox(height: 24.h),
                  // Institutional Progress
                  InstitutionalProgressCard(
                    totalIndicators: institutionalProgress.totalIndicators,
                    indicatorsWithFiles:
                        institutionalProgress.indicatorsWithFiles,
                    percentage: institutionalProgress.percentage,
                  ),
                  SizedBox(height: 40.h),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
