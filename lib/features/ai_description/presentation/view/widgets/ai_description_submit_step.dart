import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class AiDescriptionSubmitStep extends StatelessWidget {
  const AiDescriptionSubmitStep({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AiDescriptionCubit>();

    return BlocListener<AiDescriptionCubit, AiDescriptionState>(
      listener: (context, state) {},
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomText(
                title: "finalizeGeneration".tr(),
                textStyle: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.colorButtonLight,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10.h),
              CustomText(
                title: "pleaseReviewAndSubmit".tr(),
                textStyle: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.normal,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              // Stacked Fields
              PremiumInputField(
                label: "courseName".tr(),
                controller: cubit.titleController,
                icon: Icons.title_rounded,
                hint: "enterCourseName".tr(),
                maxLines: 1,
              ),
              SizedBox(height: 15.h),
              PremiumInputField(
                label: "courseDescription".tr(),
                controller: cubit.descriptionController,
                icon: Icons.description_rounded,
                hint: "enterCourseDescription".tr(),
                maxLines: 4,
              ),
              SizedBox(height: 20.h),

              BlocBuilder<AiDescriptionCubit, AiDescriptionState>(
                builder: (context, state) {
                  final bool isLoading = state is AiDescriptionSubmitLoading;

                  if (isLoading) {
                    return Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        vertical: 25.h,
                        horizontal: 20.w,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.colorButtonLight.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(15.r),
                        border: Border.all(
                          color: AppColors.colorButtonLight.withOpacity(0.3),
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: 35.h,
                            width: 35.h,
                            child: const CircularProgressIndicator(
                              color: AppColors.colorButtonLight,
                              strokeWidth: 3,
                            ),
                          ),
                          SizedBox(height: 15.h),
                          CustomText(
                            title: "aiGeneratingWait".tr(),
                            textStyle: TextStyle(
                              color: AppColors.colorButtonLight,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              height: 1.5,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  }

                  return SizedBox(
                    width: 300.w,
                    child: CustomButton(
                      buttonModel: ButtonModel(
                        onPressed: () => cubit.submitCourse(),
                        backgroundColor: AppColors.colorButtonLight,
                        radius: 15.r,
                        space: 15.h,
                        customText: CustomText(
                          title: "submitAndGenerate".tr(),
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
