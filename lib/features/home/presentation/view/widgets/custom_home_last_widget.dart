import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';
import 'package:qualiverse/features/all_features_imports/all_features_imports.dart';

class CustomHomeLastWidget extends StatefulWidget {
  const CustomHomeLastWidget({super.key, required this.homeLastBodyModel});

  final HomeLastBodyModel homeLastBodyModel;

  @override
  State<CustomHomeLastWidget> createState() => _CustomHomeLastWidgetState();
}

class _CustomHomeLastWidgetState extends State<CustomHomeLastWidget> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (event) => setState(() => isHovered = true),
        onExit: (event) => setState(() => isHovered = false),
        child: GestureDetector(
          onTap: () {},
          child: Container(
            width: 250.w,
            decoration: BoxDecoration(
              color: isHovered
                  ? (Theme.of(context).scaffoldBackgroundColor ==
                            AppColors.white
                        ? AppColors.customContainerLightHover
                        : AppColors.customContainerDarkHover)
                  : Theme.of(context).scaffoldBackgroundColor == AppColors.white
                  ? AppColors.white
                  : AppColors.black,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 65,
                  height: 65,
                  child: Image.asset(widget.homeLastBodyModel.image),
                ),
                const SizedBox(height: 20),
                CustomText(
                  title: widget.homeLastBodyModel.title.tr(),
                  textAlign: TextAlign.center,
                  textStyle: Theme.of(context).textTheme.displaySmall!.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 15),
                CustomText(
                  title: widget.homeLastBodyModel.description.tr(),
                  textAlign: TextAlign.center,
                  textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 18.sp,
                    shadows: [
                      BoxShadow(
                        spreadRadius: 0,
                        color: AppColors.sideBarTextDark.withValues(alpha: 0.4),
                        blurRadius: 3,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
