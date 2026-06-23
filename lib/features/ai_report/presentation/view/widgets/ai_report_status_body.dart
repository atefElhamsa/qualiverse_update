import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/features/ai_report/presentation/view/widgets/build_providers_header.dart';

import '../../../../../routing/all_routes_imports.dart';
import 'build_providers_list.dart';

class AiReportStatusBody extends StatelessWidget {
  final int courseId;

  const AiReportStatusBody({super.key, required this.courseId});

  @override
  Widget build(BuildContext context) {
    final isAr = context.locale.languageCode == 'ar';
    return BlocBuilder<AiReportStatusCubit, AiReportStatusState>(
      builder: (context, state) {
        return CustomScaffold(
          onRefresh: () => context.read<AiReportStatusCubit>().fetchStatus(),
          widget: Stack(
            clipBehavior: Clip.none,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const AiReportTop(),
                  if (state is AiReportStatusLoading)
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 40.h),
                      child: const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.colorButtonLight,
                        ),
                      ),
                    )
                  else if (state is AiReportStatusError)
                    AiReportStatusErrorWidget(
                      error: state.errorMessage,
                      isAr: isAr,
                    )
                  else if (state is AiReportStatusLoaded)
                    Column(
                      children: [
                        BuildProvidersHeader(isAr: isAr),
                        SizedBox(height: 10.h),
                        BuildProvidersList(
                          providers: state.providers,
                          selectedProvider: state.selectedProvider,
                          isAr: isAr,
                        ),
                        SizedBox(height: 12.h),
                        AiReportStatusCourseNatureSection(
                          selectedCourseNature: state.selectedCourseNature,
                          isAr: isAr,
                        ),
                        SizedBox(height: 16.h),
                        AiReportStatusProceedButton(
                          isAr: isAr,
                          selectedProvider: state.selectedProvider,
                          selectedCourseNature: state.selectedCourseNature,
                          courseId: courseId,
                        ),
                        SizedBox(height: 10.h),
                      ],
                    )
                  else
                    const SizedBox.shrink(),
                ],
              ),
              if (state is AiReportStatusLoaded)
                PositionedDirectional(
                  top: 30.h,
                  end: 40.w,
                  child: AiReportStatusHealthCard(
                    health: state.health,
                    isAr: isAr,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
