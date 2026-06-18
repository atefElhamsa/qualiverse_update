import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';
import 'package:qualiverse/features/all_features_imports/all_features_imports.dart';

class AiReportStatusScreen extends StatelessWidget {
  final int courseId;

  const AiReportStatusScreen({super.key, required this.courseId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AiReportStatusCubit()..fetchStatus(),
      child: MainWrapper(child: AiReportStatusBody(courseId: courseId)),
    );
  }
}

class AiReportStatusBody extends StatelessWidget {
  final int courseId;

  const AiReportStatusBody({super.key, required this.courseId});

  Widget _buildProvidersHeader(BuildContext context, bool isAr) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.w),
      child: Align(
        alignment: isAr ? Alignment.centerRight : Alignment.centerLeft,
        child: Text(
          isAr ? "مزودو الخدمة المتاحون" : "Available AI Providers",
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.colorButtonLight,
            fontSize: 18.sp,
          ),
        ),
      ),
    );
  }

  Widget _buildProvidersList(
    BuildContext context,
    AiReportProvidersModel providers,
    String? selectedProvider,
    bool isAr,
  ) {
    final list = providers.providers.entries.toList();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.w),
      child: Row(
        children: list.map((entry) {
          final String name = entry.key;
          final ProviderConfig config = entry.value;
          final bool isSelected =
              selectedProvider?.toLowerCase() == name.toLowerCase();

          return Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w),
              child: AiReportStatusProviderCard(
                name: name,
                config: config,
                isSelected: isSelected,
                isAr: isAr,
                onTap: () {
                  context.read<AiReportStatusCubit>().selectProvider(name);
                },
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

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
                        _buildProvidersHeader(context, isAr),
                        SizedBox(height: 10.h),
                        _buildProvidersList(
                          context,
                          state.providers,
                          state.selectedProvider,
                          isAr,
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
