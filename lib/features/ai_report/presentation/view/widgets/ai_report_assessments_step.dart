import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/core/utils/date_picker_utils.dart';
import 'package:qualiverse/features/ai_description/presentation/view/widgets/premium_input_field.dart';
import 'package:qualiverse/features/ai_description/presentation/view/widgets/step_wrapper.dart';
import 'package:qualiverse/features/ai_report/presentation/controller/ai_report_cubit.dart';

class AiReportAssessmentsStep extends StatefulWidget {
  const AiReportAssessmentsStep({super.key});

  @override
  State<AiReportAssessmentsStep> createState() =>
      _AiReportAssessmentsStepState();
}

class _AiReportAssessmentsStepState extends State<AiReportAssessmentsStep> {
  int _expandedIndex = 0; // Default to expanding the first exam

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AiReportCubit>();
    final isAr = context.locale.languageCode == 'ar';

    final exams = [
      _ExamConfig(
        title: isAr ? "الامتحان الأول" : "Exam 1",
        icon: Icons.filter_1_rounded,
        evalDateController: cubit.exam1EvalDateController,
        dateController: cubit.exam1DateController,
        marksController: cubit.exam1MarksController,
        typeController: cubit.exam1TypeController,
        closController: cubit.exam1ClosController,
      ),
      _ExamConfig(
        title: isAr ? "الامتحان الثاني" : "Exam 2",
        icon: Icons.filter_2_rounded,
        evalDateController: cubit.exam2EvalDateController,
        dateController: cubit.exam2DateController,
        marksController: cubit.exam2MarksController,
        typeController: cubit.exam2TypeController,
        closController: cubit.exam2ClosController,
      ),
      _ExamConfig(
        title: isAr ? "امتحان منتصف الفصل" : "Midterm Exam",
        icon: Icons.analytics_rounded,
        evalDateController: cubit.midtermEvalDateController,
        dateController: cubit.midtermDateController,
        marksController: cubit.midtermMarksController,
        typeController: cubit.midtermTypeController,
        closController: cubit.midtermClosController,
      ),
      _ExamConfig(
        title: isAr ? "الامتحان العملي" : "Practical Exam",
        icon: Icons.science_rounded,
        evalDateController: cubit.practicalEvalDateController,
        dateController: cubit.practicalDateController,
        marksController: cubit.practicalMarksController,
        typeController: cubit.practicalTypeController,
        closController: cubit.practicalClosController,
      ),
      _ExamConfig(
        title: isAr ? "الامتحان الشفوي" : "Oral Exam",
        icon: Icons.record_voice_over_rounded,
        evalDateController: cubit.oralEvalDateController,
        dateController: cubit.oralDateController,
        marksController: cubit.oralMarksController,
        typeController: cubit.oralTypeController,
        closController: cubit.oralClosController,
      ),
      _ExamConfig(
        title: isAr ? "الامتحان التحريري" : "Written Exam",
        icon: Icons.history_edu_rounded,
        evalDateController: cubit.writtenEvalDateController,
        dateController: cubit.writtenDateController,
        marksController: cubit.writtenMarksController,
        typeController: cubit.writtenTypeController,
        closController: cubit.writtenClosController,
      ),
    ];

    return StepWrapper(
      title: isAr ? "طرق وأدوات التقييم" : "Assessment Methods & Exams",
      icon: Icons.checklist_rtl_rounded,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isAr
                ? "يرجى تعبئة تفاصيل كل امتحان/أداة تقييم أدناه:"
                : "Please fill in the details for each exam/assessment tool below:",
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF0D47A1),
            ),
          ),
          SizedBox(height: 15.h),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: exams.length,
            itemBuilder: (context, index) {
              final exam = exams[index];
              final isExpanded = _expandedIndex == index;
              return Container(
                margin: EdgeInsets.only(bottom: 15.h),
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
                    color: isExpanded
                        ? const Color(0xFF0D47A1).withOpacity(0.3)
                        : const Color(0xFF0D47A1).withOpacity(0.1),
                    width: isExpanded ? 1.8 : 1.2,
                  ),
                ),
                child: Column(
                  children: [
                    // Accordion Header
                    InkWell(
                      onTap: () {
                        setState(() {
                          _expandedIndex = isExpanded ? -1 : index;
                        });
                      },
                      borderRadius: BorderRadius.circular(20.r),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                          vertical: 16.h,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 18.r,
                                  backgroundColor: isExpanded
                                      ? const Color(0xFF0D47A1)
                                      : const Color(
                                          0xFF0D47A1,
                                        ).withOpacity(0.1),
                                  child: Icon(
                                    exam.icon,
                                    color: isExpanded
                                        ? Colors.white
                                        : const Color(0xFF0D47A1),
                                    size: 20.sp,
                                  ),
                                ),
                                SizedBox(width: 12.w),
                                Text(
                                  exam.title,
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                    color: isExpanded
                                        ? const Color(0xFF0D47A1)
                                        : Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                            Icon(
                              isExpanded
                                  ? Icons.keyboard_arrow_up_rounded
                                  : Icons.keyboard_arrow_down_rounded,
                              color: const Color(0xFF0D47A1),
                              size: 24.sp,
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Accordion Content
                    AnimatedCrossFade(
                      firstChild: const SizedBox.shrink(),
                      secondChild: Padding(
                        padding: EdgeInsets.only(
                          left: 20.w,
                          right: 20.w,
                          bottom: 20.h,
                        ),
                        child: Column(
                          children: [
                            Divider(
                              color: const Color(0xFF0D47A1).withOpacity(0.1),
                              height: 1,
                              thickness: 1,
                            ),
                            SizedBox(height: 15.h),
                            Row(
                              children: [
                                Expanded(
                                  child: PremiumInputField(
                                    label: isAr
                                        ? "نوع التقييم"
                                        : "Assessment Type",
                                    controller: exam.typeController,
                                    icon: Icons.help_outline_rounded,
                                    hint: isAr
                                        ? "مثال: ورقة، مشروع"
                                        : "e.g., Paper, Project",
                                  ),
                                ),
                                SizedBox(width: 20.w),
                                Expanded(
                                  child: PremiumInputField(
                                    label: isAr ? "الدرجات" : "Marks",
                                    controller: exam.marksController,
                                    icon: Icons.grade_rounded,
                                    hint: "0",
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: PremiumInputField(
                                    label: isAr
                                        ? "تاريخ الامتحان"
                                        : "Exam Date",
                                    controller: exam.dateController,
                                    icon: Icons.calendar_today_rounded,
                                    hint: "YYYY-MM-DD",
                                    readOnly: true,
                                    onTap: () async {
                                      final date = await showPremiumDatePicker(
                                        context,
                                      );
                                      if (date != null) {
                                        exam.dateController.text = DateFormat(
                                          'yyyy-MM-dd',
                                        ).format(date);
                                      }
                                    },
                                  ),
                                ),
                                SizedBox(width: 20.w),
                                Expanded(
                                  child: PremiumInputField(
                                    label: isAr
                                        ? "تاريخ التقييم"
                                        : "Evaluation Date",
                                    controller: exam.evalDateController,
                                    icon: Icons.rate_review_rounded,
                                    hint: "YYYY-MM-DD",
                                    readOnly: true,
                                    onTap: () async {
                                      final date = await showPremiumDatePicker(
                                        context,
                                      );
                                      if (date != null) {
                                        exam.evalDateController.text =
                                            DateFormat(
                                              'yyyy-MM-dd',
                                            ).format(date);
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: PremiumInputField(
                                    label: isAr
                                        ? "مخرجات التعلم المستهدفة للمقرر (CLOs)"
                                        : "Course Learning Outcomes (CLOs)",
                                    controller: exam.closController,
                                    icon: Icons.ads_click_rounded,
                                    hint: isAr
                                        ? "مثال: K1, S2, C1"
                                        : "e.g., K1, S2, C1",
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      crossFadeState: isExpanded
                          ? CrossFadeState.showSecond
                          : CrossFadeState.showFirst,
                      duration: const Duration(milliseconds: 300),
                    ),
                  ],
                ),
              );
            },
          ),
          SizedBox(height: 20.h),
          Divider(
            color: const Color(0xFF0D47A1).withOpacity(0.15),
            thickness: 1.2,
          ),
          SizedBox(height: 15.h),
          PremiumInputField(
            label: isAr
                ? "ملاحظات وتعليقات إضافية على التقييم"
                : "Additional Assessment Comments",
            controller: cubit.assessmentCommentController,
            icon: Icons.comment_rounded,
            hint: isAr
                ? "أدخل أي ملاحظات إضافية بخصوص نظام التقييم والدرجات..."
                : "Enter any general comments or remarks about the assessment system...",
            maxLines: 4,
          ),
        ],
      ),
    );
  }
}

class _ExamConfig {
  final String title;
  final IconData icon;
  final TextEditingController evalDateController;
  final TextEditingController dateController;
  final TextEditingController marksController;
  final TextEditingController typeController;
  final TextEditingController closController;

  const _ExamConfig({
    required this.title,
    required this.icon,
    required this.evalDateController,
    required this.dateController,
    required this.marksController,
    required this.typeController,
    required this.closController,
  });
}
