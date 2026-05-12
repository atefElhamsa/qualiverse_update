import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';
import 'package:qualiverse/features/ai_description/presentation/view/widgets/ai_description_navigation_row.dart';
import 'package:qualiverse/features/ai_description/presentation/view/widgets/ai_description_steps_content.dart';
import 'package:qualiverse/features/ai_description/presentation/view/widgets/ai_step_indicator.dart';
import 'package:qualiverse/features/home/presentation/view/widgets/main_wrapper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:qualiverse/features/login/presentation/view/widgets/error_widget.dart';

import '../controller/ai_description_cubit.dart';
import 'widgets/ai_description_top.dart';
import 'widgets/ai_description_submit_step.dart';
import 'widgets/ai_description_loading_overlay.dart';

class AiDescriptionResultScreen extends StatelessWidget {
  const AiDescriptionResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainWrapper(
      child: BlocListener<AiDescriptionCubit, AiDescriptionState>(
        listener: (context, state) {
          if (state is AiDescriptionSubmitSuccess) {
            showSnackBar(
              context,
              "generationStartedSuccessfully".tr(),
              AppColors.green,
            );
          } else if (state is AiDescriptionSubmitError) {
            showSnackBar(context, state.message, AppColors.red);
          } else if (state is AiDescriptionSubmitDetailsSuccess) {
            showSnackBar(
              context,
              "detailsSubmittedSuccessfully".tr(),
              AppColors.green,
            );
          } else if (state is AiDescriptionSubmitDetailsError) {
            showSnackBar(context, state.message, AppColors.red);
          } else if (state is AiDescriptionValidationError) {
            showSnackBar(context, state.message, AppColors.red);
          } else if (state is AiDescriptionDownloadSuccess) {
            showSnackBar(context, "downloadUrlReady".tr(), AppColors.green);
            // Optionally open the URL
          } else if (state is AiDescriptionDownloadError) {
            showSnackBar(context, state.message, AppColors.red);
          } else if (state is AiDescriptionCustomUploadSuccess) {
            showSnackBar(
              context,
              "customDescriptionUploaded".tr(),
              AppColors.green,
            );
          } else if (state is AiDescriptionCustomUploadError) {
            showSnackBar(context, state.message, AppColors.red);
          } else if (state is AiDescriptionFinalConfirmSuccess) {
            showSnackBar(context, state.message, AppColors.green);
            context.pop(); // Go back to main AI page or somewhere else
          } else if (state is AiDescriptionFinalConfirmError) {
            showSnackBar(context, state.message, AppColors.red);
          }
        },
        child: BlocBuilder<AiDescriptionCubit, AiDescriptionState>(
          builder: (context, state) {
            final cubit = context.read<AiDescriptionCubit>();
            final bool isProcessing =
                state is AiDescriptionSubmitDetailsLoading ||
                state is AiDescriptionDownloadLoading ||
                state is AiDescriptionCustomUploadLoading ||
                state is AiDescriptionFinalConfirmLoading;

            return Stack(
              children: [
                CustomScaffold(
                  widget: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        const AiDescriptionTop(),
                        if (!cubit.isCourseGenerated) ...[
                          SizedBox(height: 30.h),
                          const AiDescriptionSubmitStep(),
                          const SizedBox(height: 50),
                        ] else ...[
                          if (cubit.currentPage < 5) ...[
                            AiStepIndicator(
                              currentPage: cubit.currentPage,
                              totalSteps: 5,
                            ),
                            SizedBox(height: 20.h),
                            const AiDescriptionStepsContent(),
                            SizedBox(height: 30.h),
                            const AiDescriptionNavigationRow(),
                          ] else ...[
                            const AiDescriptionStepsContent(),
                          ],
                          SizedBox(height: 50.h),
                        ],
                      ],
                    ),
                  ),
                ),
                if (isProcessing) const AiDescriptionLoadingOverlay(),
              ],
            );
          },
        ),
      ),
    );
  }
}
