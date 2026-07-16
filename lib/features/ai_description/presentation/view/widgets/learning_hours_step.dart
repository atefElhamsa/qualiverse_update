import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LearningHoursStep extends StatelessWidget {
  const LearningHoursStep({super.key});

  @override
  Widget build(BuildContext context) {
    return StepWrapper(
      title: "learningHoursWeekly".tr(),
      icon: Icons.access_time_filled_rounded,
      child: BlocBuilder<AiDescriptionCubit, AiDescriptionState>(
        builder: (context, state) {
          final cubit = context.read<AiDescriptionCubit>();
          return Column(
            children: [
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 25.w,
                  mainAxisSpacing: 25.h,
                  mainAxisExtent: 480.h,
                ),
                itemCount: cubit.learningWeeksCount,
                itemBuilder: (context, index) {
                  return WeeklyLearningCard(
                    week: index + 1,
                    controllers: cubit.weekControllers[index],
                    onRemove: index >= 2
                        ? () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                backgroundColor: Colors.white,
                                surfaceTintColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.r),
                                ),
                                title: Text(
                                  "deleteWeek".tr(),
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFF0D47A1),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                content: Text(
                                  "areYouSureYouWantToDeleteThisWeek".tr(),
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: Colors.black.withOpacity(0.7),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                actionsPadding: EdgeInsets.only(
                                  bottom: 20.h,
                                  left: 15.w,
                                  right: 15.w,
                                ),
                                actions: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: OutlinedButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          style: OutlinedButton.styleFrom(
                                            side: const BorderSide(
                                              color: Colors.grey,
                                            ),
                                            padding: EdgeInsets.symmetric(
                                              vertical: 10.h,
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.r),
                                            ),
                                          ),
                                          child: Text(
                                            "cancel".tr(),
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 13.sp,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 12.w),
                                      Expanded(
                                        child: ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                            cubit.removeLearningWeek(index);
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.red,
                                            padding: EdgeInsets.symmetric(
                                              vertical: 10.h,
                                            ),
                                            elevation: 0,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.r),
                                            ),
                                          ),
                                          child: Text(
                                            "delete".tr(),
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 13.sp,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          }
                        : null,
                  );
                },
              ),
              SizedBox(height: 30.h),
              InkWell(
                onTap: () => cubit.addLearningWeek(),
                borderRadius: BorderRadius.circular(15.r),
                child: Container(
                  width: 250.w,
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0D47A1).withOpacity(0.05),
                    borderRadius: BorderRadius.circular(15.r),
                    border: Border.all(
                      color: const Color(0xFF0D47A1).withOpacity(0.3),
                      width: 1.5,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add_circle_outline_rounded,
                        color: const Color(0xFF0D47A1),
                        size: 22.sp,
                      ),
                      SizedBox(width: 10.w),
                      Text(
                        "addWeek".tr(),
                        style: TextStyle(
                          color: const Color(0xFF0D47A1),
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
