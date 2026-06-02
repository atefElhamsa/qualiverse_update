import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/features/ai_description/presentation/view/widgets/premium_input_field.dart';
import 'package:qualiverse/features/ai_description/presentation/view/widgets/step_wrapper.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';
import 'package:qualiverse/features/ai_report/presentation/controller/ai_report_cubit.dart';
import 'package:qualiverse/features/ai_report/presentation/controller/ai_report_state.dart';

class AiReportInstructorsStep extends StatelessWidget {
  const AiReportInstructorsStep({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AiReportCubit>();
    final isAr = context.locale.languageCode == 'ar';

    return StepWrapper(
      title: isAr ? "أعضاء هيئة التدريس والمعيدين" : "Faculty & TAs Info",
      icon: Icons.people_alt_rounded,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Row of full-time and part-time staff counts
          Row(
            children: [
              Expanded(
                child: PremiumInputField(
                  label: isAr
                      ? "أعضاء هيئة تدريس (متفرغين)"
                      : "Full-time Instructors",
                  controller: cubit.instructorFulltimeController,
                  icon: Icons.person_pin_rounded,
                  hint: "0",
                ),
              ),
              SizedBox(width: 20.w),
              Expanded(
                child: PremiumInputField(
                  label: isAr
                      ? "أعضاء هيئة تدريس (غير متفرغين)"
                      : "Part-time Instructors",
                  controller: cubit.instructorParttimeController,
                  icon: Icons.person_pin_outlined,
                  hint: "0",
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: PremiumInputField(
                  label: isAr ? "الهيئة المعاونة (متفرغين)" : "Full-time TAs",
                  controller: cubit.taFulltimeController,
                  icon: Icons.supervised_user_circle_rounded,
                  hint: "0",
                ),
              ),
              SizedBox(width: 20.w),
              Expanded(
                child: PremiumInputField(
                  label: isAr
                      ? "الهيئة المعاونة (غير متفرغين)"
                      : "Part-time TAs",
                  controller: cubit.taParttimeController,
                  icon: Icons.supervised_user_circle_outlined,
                  hint: "0",
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Divider(
            color: const Color(0xFF0D47A1).withOpacity(0.15),
            thickness: 1.2,
          ),
          SizedBox(height: 15.h),

          // Title for Instructors list
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                isAr ? "قائمة أعضاء هيئة التدريس" : "Instructors List",
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF0D47A1),
                ),
              ),
              // Beautiful dynamic Add Button
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () => cubit.addInstructor(),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 14.w,
                      vertical: 8.h,
                    ),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF0D47A1), Color(0xFF1976D2)],
                      ),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.add_circle_outline_rounded,
                          color: Colors.white,
                          size: 18.sp,
                        ),
                        SizedBox(width: 6.w),
                        Text(
                          isAr ? "إضافة دكتور" : "Add Instructor",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 15.h),

          // Dynamic Shaded Box/Card for Instructors
          BlocBuilder<AiReportCubit, AiReportState>(
            builder: (context, state) {
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: cubit.instructorsList.length,
                itemBuilder: (context, index) {
                  final instructor = cubit.instructorsList[index];
                  return Container(
                    margin: EdgeInsets.only(bottom: 16.h),
                    padding: EdgeInsets.all(20.r),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.r),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF0D47A1).withOpacity(0.04),
                          blurRadius: 16,
                          offset: const Offset(0, 8),
                        ),
                      ],
                      border: Border.all(
                        color: const Color(0xFF0D47A1).withOpacity(0.12),
                        width: 1.2,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Card Header
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 14.r,
                                  backgroundColor: const Color(
                                    0xFF0D47A1,
                                  ).withOpacity(0.1),
                                  child: Text(
                                    "${index + 1}",
                                    style: TextStyle(
                                      color: const Color(0xFF0D47A1),
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8.w),
                                Text(
                                  isAr
                                      ? "بيانات الدكتور رقم (${index + 1})"
                                      : "Instructor #${index + 1} Details",
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(
                                      0xFF0D47A1,
                                    ).withOpacity(0.8),
                                  ),
                                ),
                              ],
                            ),
                            if (cubit.instructorsList.length > 1)
                              MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: GestureDetector(
                                  onTap: () => cubit.removeInstructor(index),
                                  child: Icon(
                                    Icons.delete_sweep_rounded,
                                    color: AppColors.red,
                                    size: 22.sp,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        SizedBox(height: 15.h),

                        // Form Fields Grid
                        Row(
                          children: [
                            Expanded(
                              child: PremiumInputField(
                                label: isAr ? "الاسم كامل" : "Full Name",
                                controller: instructor.nameController,
                                icon: Icons.person_rounded,
                                hint: isAr ? "ادخل الاسم" : "Enter Name",
                              ),
                            ),
                            SizedBox(width: 20.w),
                            Expanded(
                              child: PremiumInputField(
                                label: isAr ? "القسم" : "Department",
                                controller: instructor.deptController,
                                icon: Icons.apartment_rounded,
                                hint: isAr ? "ادخل القسم" : "Enter Dept",
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: PremiumInputField(
                                label: isAr ? "الدرجة العلمية" : "Degree",
                                controller: instructor.degreeController,
                                icon: Icons.military_tech_rounded,
                                hint: isAr ? "مثال: دكتوراه" : "e.g., PhD",
                              ),
                            ),
                            SizedBox(width: 20.w),
                            Expanded(
                              child: PremiumInputField(
                                label: isAr ? "التخصص" : "Specialty",
                                controller: instructor.specialtyController,
                                icon: Icons.workspace_premium_rounded,
                                hint: isAr ? "ادخل التخصص" : "Enter Specialty",
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
