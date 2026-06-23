import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';
import 'package:qualiverse/features/ai_report/presentation/controller/ai_report_history_cubit.dart';
import 'package:qualiverse/features/ai_report/presentation/controller/ai_report_history_state.dart';
import 'package:qualiverse/features/ai_report/presentation/view/widgets/ai_report_history_card.dart';

import 'dart:ui' as ui;

class AiReportHistoryScreen extends StatelessWidget {
  const AiReportHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AiReportHistoryCubit()..fetchHistory(),
      child: Scaffold(
        body: CustomScaffold(
          widget: Directionality(
            textDirection: context.locale.languageCode == 'ar'
                ? ui.TextDirection.rtl
                : ui.TextDirection.ltr,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 16.h,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "aiModel".tr(),
                        style: GoogleFonts.almarai(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w800,
                          color: AppColors.aiPrimary,
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          context.locale.languageCode == 'ar'
                              ? Icons.arrow_forward_ios
                              : Icons.arrow_back_ios,
                          color: AppColors.mainBlack,
                        ),
                        onPressed: () => context.pop(),
                      ),
                    ],
                  ),
                ),
                Divider(height: 1, color: AppColors.grey.withOpacity(0.5)),

                Padding(
                  padding: EdgeInsets.all(24.w),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.history_edu,
                            size: 36.sp,
                            color: AppColors.aiPrimary,
                          ),
                          SizedBox(width: 12.w),
                          Text(
                            context.locale.languageCode == 'ar'
                                ? 'سجل تقارير الذكاء الاصطناعي'
                                : 'AI Reports History',
                            style: GoogleFonts.almarai(
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w800,
                              color: AppColors.mainBlack,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      BlocBuilder<AiReportHistoryCubit, AiReportHistoryState>(
                        builder: (context, state) {
                          int count = 0;
                          if (state is AiReportHistoryLoaded) {
                            count = state.historyItems.length;
                          }
                          return Text(
                            context.locale.languageCode == 'ar'
                                ? 'عدد التقارير: $count'
                                : 'Reports Count: $count',
                            style: GoogleFonts.almarai(
                              fontSize: 16.sp,
                              color: AppColors.mainGrey,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),

                BlocBuilder<AiReportHistoryCubit, AiReportHistoryState>(
                  builder: (context, state) {
                    if (state is AiReportHistoryLoading) {
                      return SizedBox(
                        height: 300.h,
                        child: const Center(child: CircularProgressIndicator()),
                      );
                    } else if (state is AiReportHistoryError) {
                      return SizedBox(
                        height: 300.h,
                        child: Center(
                          child: Text(
                            context.locale.languageCode == 'ar'
                                ? 'حدث خطأ: ${state.message}'
                                : 'Error: ${state.message}',
                            style: GoogleFonts.almarai(
                              color: AppColors.red,
                              fontSize: 18.sp,
                            ),
                          ),
                        ),
                      );
                    } else if (state is AiReportHistoryLoaded) {
                      if (state.historyItems.isEmpty) {
                        return SizedBox(
                          height: 300.h,
                          child: Center(
                            child: Text(
                              context.locale.languageCode == 'ar'
                                  ? 'لا يوجد سجل تقارير'
                                  : 'No reports found',
                              style: GoogleFonts.almarai(
                                color: AppColors.mainGrey,
                                fontSize: 18.sp,
                              ),
                            ),
                          ),
                        );
                      }

                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.historyItems.length,
                          itemBuilder: (context, index) {
                            final item = state.historyItems[index];
                            return AiReportHistoryCard(
                              item: item,
                              onPublish: () {
                                context
                                    .read<AiReportHistoryCubit>()
                                    .publishReport(item.aiRequestId);
                              },
                            );
                          },
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
                SizedBox(height: 32.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
