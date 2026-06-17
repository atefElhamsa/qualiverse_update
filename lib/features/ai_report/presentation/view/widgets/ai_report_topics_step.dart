import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class AiReportTopicsStep extends StatelessWidget {
  const AiReportTopicsStep({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AiReportCubit>();
    final isAr = context.locale.languageCode == 'ar';

    return StepWrapper(
      title: isAr
          ? "تغطية الموضوعات وطرق التدريس"
          : "Topics Coverage & Teaching Changes",
      icon: Icons.article_rounded,
      child: Column(
        children: [
          PremiumInputField(
            label: isAr
                ? "الموضوعات التي لم يتم تغطيتها"
                : "Topics Not Covered",
            controller: cubit.topicsNotCoveredController,
            icon: Icons.list_alt_rounded,
            hint: isAr
                ? "أدخل الموضوعات التي لم يتم تغطيتها بالكامل وأسباب ذلك..."
                : "Enter any course syllabus topics that were not fully covered...",
            maxLines: 4,
          ),
          SizedBox(height: 15.h),
          PremiumInputField(
            label: isAr
                ? "التعديلات المقترحة في طرق التدريس"
                : "Proposed Teaching Method Changes",
            controller: cubit.teachingMethodChangesController,
            icon: Icons.psychology_rounded,
            hint: isAr
                ? "أدخل أي تغييرات أو تعديلات مقترحة لتحسين طرق التدريس..."
                : "Enter any proposed improvements or changes in teaching methods...",
            maxLines: 4,
          ),
        ],
      ),
    );
  }
}
