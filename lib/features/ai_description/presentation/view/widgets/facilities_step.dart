import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/features/ai_description/presentation/controller/ai_description_cubit.dart';
import 'premium_input_field.dart';
import 'step_wrapper.dart';

class FacilitiesStep extends StatelessWidget {
  const FacilitiesStep({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AiDescriptionCubit>();
    return StepWrapper(
      title: "facilities".tr(),
      icon: Icons.business_rounded,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: PremiumInputField(
                  label: "devices".tr(),
                  controller: cubit.devicesController,
                  icon: Icons.devices_rounded,
                  hint: "enterDevices".tr(),
                ),
              ),
              SizedBox(width: 20.w),
              Expanded(
                child: PremiumInputField(
                  label: "supplies".tr(),
                  controller: cubit.suppliesController,
                  icon: Icons.inventory_2_rounded,
                  hint: "enterSupplies".tr(),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: PremiumInputField(
                  label: "programs".tr(),
                  controller: cubit.softwareController,
                  icon: Icons.code_rounded,
                  hint: "enterSoftware".tr(),
                ),
              ),
              SizedBox(width: 20.w),
              Expanded(
                child: PremiumInputField(
                  label: "skillLabs".tr(),
                  controller: cubit.labsController,
                  icon: Icons.science_rounded,
                  hint: "enterLabs".tr(),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: PremiumInputField(
                  label: "virtualLabs".tr(),
                  controller: cubit.virtualLabsController,
                  icon: Icons.vrpano_rounded,
                  hint: "enterVirtualLabs".tr(),
                ),
              ),
              SizedBox(width: 20.w),
              Expanded(
                child: PremiumInputField(
                  label: "other".tr(),
                  controller: cubit.otherFacController,
                  icon: Icons.more_horiz_rounded,
                  hint: "enterOther".tr(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
