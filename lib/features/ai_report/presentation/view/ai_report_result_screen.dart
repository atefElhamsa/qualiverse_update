import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class AiReportResultScreen extends StatelessWidget {
  final AiReportExtractResponse? extractResponse;

  const AiReportResultScreen({super.key, this.extractResponse});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = AiReportCubit();
        if (extractResponse != null) {
          cubit.init(extractResponse!.rawJson);
        }
        return cubit;
      },
      child: const AiReportResultView(),
    );
  }
}

class AiReportResultView extends StatelessWidget {
  const AiReportResultView({super.key});

  @override
  Widget build(BuildContext context) {
    return MainWrapper(
      child: BlocListener<AiReportCubit, AiReportState>(
        listener: (context, state) {
          if (state is AiReportSuccess) {
            if (state.jobId != null && state.jobId!.isNotEmpty) {
              context.goNamed(
                AppRoutes.aiReportJobStatusScreen,
                extra: state.jobId,
              );
            } else {
              context.go(AppRoutes.homeScreen);
            }
          } else if (state is AiReportError) {
            showSnackBar(context, state.message, AppColors.red);
          }
        },
        child: BlocBuilder<AiReportCubit, AiReportState>(
          builder: (context, state) {
            final cubit = context.read<AiReportCubit>();

            return Stack(
              children: [
                CustomScaffold(
                  widget: SingleChildScrollView(
                    child: Column(
                      children: [
                        const AiReportTop(),
                        AiStepIndicator(
                          currentPage: cubit.currentPage,
                          totalSteps: 5,
                        ),
                        SizedBox(height: 20.h),
                        const AiReportStepsContent(),
                        SizedBox(height: 30.h),
                        const AiReportNavigationRow(),
                        SizedBox(height: 40.h),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
