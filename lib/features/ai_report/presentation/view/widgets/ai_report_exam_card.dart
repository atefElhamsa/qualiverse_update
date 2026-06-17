import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class AiReportExamCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isExpanded;
  final VoidCallback onTap;
  final TextEditingController evalDateController;
  final TextEditingController dateController;
  final TextEditingController marksController;
  final TextEditingController typeController;
  final TextEditingController closController;
  final bool isAr;

  const AiReportExamCard({
    super.key,
    required this.title,
    required this.icon,
    required this.isExpanded,
    required this.onTap,
    required this.evalDateController,
    required this.dateController,
    required this.marksController,
    required this.typeController,
    required this.closController,
    required this.isAr,
  });

  @override
  Widget build(BuildContext context) {
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
            onTap: onTap,
            borderRadius: BorderRadius.circular(20.r),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 18.r,
                        backgroundColor: isExpanded
                            ? const Color(0xFF0D47A1)
                            : const Color(0xFF0D47A1).withOpacity(0.1),
                        child: Icon(
                          icon,
                          color: isExpanded
                              ? Colors.white
                              : const Color(0xFF0D47A1),
                          size: 20.sp,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Text(
                        title,
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
              padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 20.h),
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
                          label: isAr ? "نوع التقييم" : "Assessment Type",
                          controller: typeController,
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
                          controller: marksController,
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
                          label: isAr ? "تاريخ الامتحان" : "Exam Date",
                          controller: dateController,
                          icon: Icons.calendar_today_rounded,
                          hint: "YYYY-MM-DD",
                          readOnly: true,
                          onTap: () async {
                            final date = await showPremiumDatePicker(context);
                            if (date != null) {
                              dateController.text = DateFormat(
                                'yyyy-MM-dd',
                              ).format(date);
                            }
                          },
                        ),
                      ),
                      SizedBox(width: 20.w),
                      Expanded(
                        child: PremiumInputField(
                          label: isAr ? "تاريخ التقييم" : "Evaluation Date",
                          controller: evalDateController,
                          icon: Icons.rate_review_rounded,
                          hint: "YYYY-MM-DD",
                          readOnly: true,
                          onTap: () async {
                            final date = await showPremiumDatePicker(context);
                            if (date != null) {
                              evalDateController.text = DateFormat(
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
                          controller: closController,
                          icon: Icons.ads_click_rounded,
                          hint: isAr ? "مثال: K1, S2, C1" : "e.g., K1, S2, C1",
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
  }
}
