import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class AiReportBasicInfoStep extends StatelessWidget {
  const AiReportBasicInfoStep({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AiReportCubit>();
    cubit.initializeLocalizedValues(context);

    return StepWrapper(
      title: "basicInfo".tr(),
      icon: Icons.assignment_rounded,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: PremiumInputField(
                  label: "courseTitle".tr(),
                  controller: cubit.titleController,
                  icon: Icons.title_rounded,
                  hint: "enterTitle".tr(),
                ),
              ),
              SizedBox(width: 20.w),
              Expanded(
                child: PremiumInputField(
                  label: "courseCode".tr(),
                  controller: cubit.codeController,
                  icon: Icons.qr_code_rounded,
                  hint: "enterCode".tr(),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: PremiumInputField(
                  label: "academicYear".tr(),
                  controller: cubit.yearController,
                  icon: Icons.date_range_rounded,
                  hint: "enterYear".tr(),
                  readOnly: true,
                  onTap: () async {
                    final date = await showPremiumDatePicker(context);
                    if (date != null) {
                      cubit.yearController.text = DateFormat(
                        'yyyy-MM-dd',
                      ).format(date);
                    }
                  },
                ),
              ),
              SizedBox(width: 20.w),
              Expanded(
                child: PremiumDropdownField(
                  label: "semester".tr(),
                  controller: cubit.semesterController,
                  items: const ["First Term", "Second Term"],
                  onChanged: (val) {
                    cubit.semesterController.text = val;
                  },
                  icon: Icons.calendar_today_rounded,
                  hint: "semester".tr(),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: PremiumDropdownField(
                  label: "department".tr(),
                  controller: cubit.deptController,
                  items: const [
                    "Computer Science",
                    "Information Technology",
                    "Software Engineering",
                    "Information System",
                    "Data Analysis and Artificial Intelligence",
                  ],
                  onChanged: (val) {
                    cubit.deptController.text = val;
                  },
                  icon: Icons.account_tree_rounded,
                  hint: "enterDept".tr(),
                ),
              ),
              SizedBox(width: 20.w),
              Expanded(
                child: PremiumDropdownField(
                  label: "courseType".tr(),
                  controller: cubit.typeController,
                  items: const ["Theoretical", "Practical"],
                  onChanged: (val) {
                    cubit.typeController.text = val;
                  },
                  icon: Icons.category_rounded,
                  hint: "enterType".tr(),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: PremiumInputField(
                  label: "academicProgram".tr(),
                  controller: cubit.programController,
                  icon: Icons.school_rounded,
                  hint: "enterProgram".tr(),
                ),
              ),
              SizedBox(width: 20.w),
              Expanded(
                child: PremiumInputField(
                  label: "faculty".tr(),
                  controller: cubit.facultyController,
                  icon: Icons.business_rounded,
                  hint: "enterFaculty".tr(),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: PremiumDropdownField(
                  label: "academicLevel".tr(),
                  controller: cubit.levelController,
                  items: const ["Level 1", "Level 2", "Level 3", "Level 4"],
                  onChanged: (val) {
                    cubit.levelController.text = val;
                  },
                  icon: Icons.layers_rounded,
                  hint: "enterLevel".tr(),
                ),
              ),
              SizedBox(width: 20.w),
              Expanded(
                child: PremiumInputField(
                  label: "university".tr(),
                  controller: cubit.uniController,
                  icon: Icons.account_balance_rounded,
                  hint: "enterUni".tr(),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: PremiumInputField(
                  label: "coordinator".tr(),
                  controller: cubit.coordinatorController,
                  icon: Icons.person_rounded,
                  hint: "enterCoordinator".tr(),
                ),
              ),
              const Spacer(),
            ],
          ),
        ],
      ),
    );
  }
}
