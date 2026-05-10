import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/features/ai_description/presentation/controller/ai_description_cubit.dart';
import 'premium_input_field.dart';
import 'step_wrapper.dart';

class BasicInfoStep extends StatelessWidget {
  const BasicInfoStep({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AiDescriptionCubit>();
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
                  label: "department".tr(),
                  controller: cubit.deptController,
                  icon: Icons.account_tree_rounded,
                  hint: "enterDept".tr(),
                ),
              ),
              SizedBox(width: 20.w),
              Expanded(
                child: PremiumInputField(
                  label: "courseType".tr(),
                  controller: cubit.typeController,
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
                child: PremiumInputField(
                  label: "academicLevel".tr(),
                  controller: cubit.levelController,
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
              SizedBox(width: 20.w),
              Expanded(
                child: PremiumInputField(
                  label: "approvalDate".tr(),
                  controller: cubit.dateController,
                  icon: Icons.calendar_today_rounded,
                  hint: "enterDate".tr(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
