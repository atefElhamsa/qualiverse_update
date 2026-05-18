import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class StartEndNumberFileCompleted extends StatefulWidget {
  const StartEndNumberFileCompleted({
    super.key,
    required this.countUploadedFileDone,
    required this.maxFiles,
    required this.courseId,
  });

  // Counter for the number of files that have been uploaded.
  final int countUploadedFileDone;

  // Maximum number of files that can be uploaded.
  final int maxFiles;

  final int courseId;

  @override
  State<StartEndNumberFileCompleted> createState() =>
      _StartEndNumberFileCompletedState();
}

class _StartEndNumberFileCompletedState
    extends State<StartEndNumberFileCompleted> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AiDescriptionCubit, AiDescriptionState>(
      builder: (context, state) {
        final cubit = context.read<AiDescriptionCubit>();
        final bool isStarted = cubit.isGenerationStarted;
        final bool isLoading = state is AiDescriptionStartLoading;

        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 154.w,
              height: 48.h,
              child: isStarted
                  ? CustomButton(
                      buttonModel: ButtonModel(
                        onPressed: () {
                          cubit.endGeneration();
                        },
                        backgroundColor: AppColors.red,
                        radius: 32,
                        customText: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.stop_circle_outlined, color: AppColors.white, size: 20.sp),
                            SizedBox(width: 8.w),
                            CustomText(
                              title: "end".tr(),
                              textStyle: Theme.of(context)
                                  .textTheme
                                  .headlineLarge!
                                  .copyWith(color: AppColors.white, fontSize: 18.sp),
                            ),
                          ],
                        ),
                      ),
                    )
                  : (isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : CustomButton(
                          buttonModel: ButtonModel(
                            onPressed: () {
                              cubit.startAiGeneration(courseId: widget.courseId);
                            },
                            backgroundColor: AppColors.colorButtonLight,
                            radius: 32,
                            customText: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.play_circle_outline, color: AppColors.white, size: 20.sp),
                                SizedBox(width: 8.w),
                                CustomText(
                                  title: "start".tr(),
                                  textStyle: Theme.of(context)
                                      .textTheme
                                      .headlineLarge!
                                      .copyWith(color: AppColors.white, fontSize: 18.sp),
                                ),
                              ],
                              
                            ),
                          ),
                        )),
            ),
            const Spacer(),
            // Number of files completed
            Row(
              children: [
                CustomText(
                  title: "${widget.countUploadedFileDone} / ${widget.maxFiles}",
                  textStyle: Theme.of(
                    context,
                  ).textTheme.headlineLarge!.copyWith(fontSize: 24.sp),
                ),
                const SizedBox(width: 10),
                CustomText(
                  title: "indicatorsCompleted".tr(),
                  textStyle: Theme.of(
                    context,
                  ).textTheme.headlineLarge!.copyWith(fontSize: 24.sp),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
