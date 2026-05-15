import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';


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
            context.pop();
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
                  widget: Column(
                    children: [
                      const AiDescriptionTop(),
                      if (!cubit.isCourseGenerated) ...[
                        const AiDescriptionSubmitStep(),
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
                        SizedBox(height: 40.h),
                      ],
                    ],
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
