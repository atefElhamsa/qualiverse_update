import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/features/all_features_imports/all_features_imports.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';
import 'package:go_router/go_router.dart';
import 'package:qualiverse/routing/app_routes.dart';

class AiReportResultScreen extends StatelessWidget {
  const AiReportResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AiReportCubit(),
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
            showSnackBar(context, state.message, AppColors.green);
            context.go(AppRoutes.homeScreen);
          } else if (state is AiReportError) {
            showSnackBar(context, state.message, AppColors.red);
          }
        },
        child: BlocBuilder<AiReportCubit, AiReportState>(
          builder: (context, state) {
            final cubit = context.read<AiReportCubit>();
            final bool isLoading = state is AiReportLoading;

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
                if (isLoading) const Center(child: CircularProgressIndicator()),
              ],
            );
          },
        ),
      ),
    );
  }
}
