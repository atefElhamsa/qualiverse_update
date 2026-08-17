import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../routing/all_routes_imports.dart';

class AiReportJobStatusBody extends StatelessWidget {
  const AiReportJobStatusBody({super.key});

  @override
  Widget build(BuildContext context) {
    final isAr = context.locale.languageCode == 'ar';
    return BlocBuilder<AiReportJobStatusCubit, AiReportJobStatusState>(
      builder: (context, state) {
        return CustomScaffold(
          widget: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const AiReportTop(hideHistory: true, disableSidebar: false),
              SizedBox(height: 20.h),
              if (state is AiReportJobStatusLoading) ...[
                AiReportJobStatusLoadingWidget(isAr: isAr),
                if (state.data != null)
                  AiReportJobStatusInfoCard(data: state.data!, isAr: isAr),
              ] else if (state is AiReportJobStatusError) ...[
                AiReportStatusErrorWidget(
                  error: state.message,
                  isAr: isAr,
                  onRetry: () =>
                      context.read<AiReportJobStatusCubit>().startPolling(),
                ),
              ] else if (state is AiReportJobStatusSuccess) ...[
                Padding(
                  padding: EdgeInsets.only(top: 10.h, bottom: 20.h),
                  child: Icon(
                    Icons.task_alt_rounded,
                    color: Colors.green.shade600,
                    size: 80.sp,
                  ),
                ),
                AiReportJobStatusInfoCard(data: state.data, isAr: isAr),
                SizedBox(height: 30.h),
                AiReportJobStatusDownloadButtons(data: state.data, isAr: isAr),
                SizedBox(height: 20.h),
              ],
            ],
          ),
        );
      },
    );
  }
}
