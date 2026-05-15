import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

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
                child: PremiumMultiSelectField(
                  label: "devices".tr(),
                  controller: cubit.devicesController,
                  items: [
                    "Projector",
                    "Smart Board",
                    "Sound System",
                    "Visualizer",
                    "PC / Laptop",
                    "Server",
                    "IoT Kits",
                    "VR Headset",
                  ],
                  icon: Icons.devices_rounded,
                  hint: "selectDevices".tr(),
                ),
              ),
              SizedBox(width: 20.w),
              Expanded(
                child: PremiumMultiSelectField(
                  label: "supplies".tr(),
                  controller: cubit.suppliesController,
                  items: [
                    "Whiteboard Markers",
                    "Stationary",
                    "Lab Equipment",
                    "Printed Materials",
                    "Ethernet Cables",
                    "Flash Drives",
                  ],
                  icon: Icons.inventory_2_rounded,
                  hint: "selectSupplies".tr(),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: PremiumMultiSelectField(
                  label: "programs".tr(),
                  controller: cubit.softwareController,
                  items: [
                    "MATLAB",
                    "SPSS",
                    "Office 365",
                    "AutoCAD",
                    "Python IDE",
                    "Visual Studio",
                    "Docker",
                    "Database Tools",
                    "Mobile Dev Tools",
                    "Game Engines",
                  ],
                  icon: Icons.code_rounded,
                  hint: "selectSoftware".tr(),
                ),
              ),
              SizedBox(width: 20.w),
              Expanded(
                child: PremiumMultiSelectField(
                  label: "skillLabs".tr(),
                  controller: cubit.labsController,
                  items: [
                    "Computer Science",
                    "Information Technology",
                    "Information Systems",
                    "Artificial Intelligence",
                    "Network Lab",
                    "Cybersecurity Lab",
                    "Robotics Lab",
                  ],
                  icon: Icons.science_rounded,
                  hint: "selectLabs".tr(),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: PremiumMultiSelectField(
                  label: "virtualLabs".tr(),
                  controller: cubit.virtualLabsController,
                  items: [
                    "Phet",
                    "Labster",
                    "Virtual Lab",
                    "Packet Tracer",
                    "Virtualization",
                    "Google Colab",
                  ],
                  icon: Icons.vrpano_rounded,
                  hint: "selectVirtualLabs".tr(),
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
