import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class AiDescriptionResultScreen extends StatefulWidget {
  const AiDescriptionResultScreen({super.key, required this.title});
  final String title;

  @override
  State<AiDescriptionResultScreen> createState() =>
      _AiDescriptionResultScreenState();
}

class _AiDescriptionResultScreenState extends State<AiDescriptionResultScreen> {
  late final AiDescriptionCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<AiDescriptionCubit>();
  }

  @override
  void dispose() {
    if (_cubit.isGenerationStarted &&
        _cubit.state is! AiDescriptionFinalConfirmSuccess) {
      _cubit.endGeneration();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AiDescriptionCubit, AiDescriptionState>(
      listener: (context, state) {
        if (state is AiDescriptionSubmitError) {
          showSnackBar(context, state.message, AppColors.red);
        } else if (state is AiDescriptionSubmitDetailsError) {
          showSnackBar(context, state.message, AppColors.red);
        } else if (state is AiDescriptionValidationError) {
          showSnackBar(context, state.message, AppColors.red);
        } else if (state is AiDescriptionDownloadError) {
          showSnackBar(context, state.message, AppColors.red);
        } else if (state is AiDescriptionCustomUploadError) {
          showSnackBar(context, state.message, AppColors.red);
        } else if (state is AiDescriptionFinalConfirmSuccess) {
          showSnackBar(context, state.message, AppColors.green);
          context.read<AiDescriptionCubit>().reset();
          context.go(AppRoutes.homeScreen);
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

          String? loadingMessage;
          if (state is AiDescriptionSubmitDetailsLoading) {
            loadingMessage = "generatingFile";
          }

          return MainWrapper(
            disabledGestures: cubit.currentPage == 5,
            disableDrawer: true,
            child: Stack(
              children: [
                CustomScaffold(
                  widget: Column(
                    children: [
                      AiDescriptionTop(title: widget.title),
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
                if (isProcessing)
                  AiDescriptionLoadingOverlay(message: loadingMessage),
              ],
            ),
          );
        },
      ),
    );
  }
}
