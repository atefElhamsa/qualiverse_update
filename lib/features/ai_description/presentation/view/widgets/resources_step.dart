import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/features/ai_description/presentation/controller/ai_description_cubit.dart';
import 'premium_input_field.dart';
import 'step_wrapper.dart';

class ResourcesStep extends StatelessWidget {
  const ResourcesStep({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AiDescriptionCubit>();
    return StepWrapper(
      title: "resources".tr(),
      icon: Icons.menu_book_rounded,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: PremiumInputField(
                  label: "mainReference".tr(),
                  controller: cubit.mainRefController,
                  icon: Icons.book_rounded,
                  hint: "enterRef".tr(),
                ),
              ),
              SizedBox(width: 20.w),
              Expanded(
                child: PremiumInputField(
                  label: "otherReferences".tr(),
                  controller: cubit.otherRefsController,
                  icon: Icons.library_books_rounded,
                  hint: "enterOtherRefs".tr(),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: PremiumInputField(
                  label: "electronicSources".tr(),
                  controller: cubit.electronicController,
                  icon: Icons.cloud_rounded,
                  hint: "enterElectronic".tr(),
                ),
              ),
              SizedBox(width: 20.w),
              Expanded(
                child: PremiumInputField(
                  label: "learningPlatforms".tr(),
                  controller: cubit.platformsController,
                  icon: Icons.computer_rounded,
                  hint: "enterPlatforms".tr(),
                ),
              ),
            ],
          ),
          PremiumInputField(
            label: "other".tr(),
            controller: cubit.otherResController,
            icon: Icons.more_horiz_rounded,
            hint: "enterOther".tr(),
          ),
        ],
      ),
    );
  }
}
