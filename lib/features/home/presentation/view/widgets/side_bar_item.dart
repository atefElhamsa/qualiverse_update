import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';
import 'package:qualiverse/features/home/data/models/side_bar_item_model.dart';

class SideBarItem extends StatefulWidget {
  final AdvancedDrawerController? controller;
  final SideBarItemModel sideBarItemModel;

  const SideBarItem({
    super.key,
    this.controller,
    required this.sideBarItemModel,
  });

  @override
  State<SideBarItem> createState() => _SideBarItemState();
}

class _SideBarItemState extends State<SideBarItem> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final String currentRoute = GoRouterState.of(context).matchedLocation;
    final bool isSelected = currentRoute == widget.sideBarItemModel.route;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
      child: MouseRegion(
        onEnter: (_) => setState(() => isHovered = true),
        onExit: (_) => setState(() => isHovered = false),
        cursor: SystemMouseCursors.click,
        child: InkWell(
          mouseCursor: SystemMouseCursors.click,
          onTap: () {
            widget.controller?.hideDrawer();
            context.push(widget.sideBarItemModel.route!);
          },
          borderRadius: BorderRadius.circular(12.r),
          child: AnimatedScale(
            scale: isHovered && !isSelected ? 1.02 : 1.0,
            duration: const Duration(milliseconds: 200),
            child:
                AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Colors.white.withOpacity(0.12)
                            : isHovered
                            ? Colors.white.withOpacity(0.05)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 12.w),
                        leading: ImageIcon(
                          AssetImage(widget.sideBarItemModel.image),
                          size: 20.sp,
                          color: isSelected
                              ? Colors.white
                              : Colors.white.withOpacity(0.4),
                        ),
                        title: CustomText(
                          title: widget.sideBarItemModel.title.tr(),
                          textStyle: TextStyle(
                            color: isSelected
                                ? Colors.white
                                : Colors.white.withOpacity(0.5),
                            fontWeight: isSelected
                                ? FontWeight.w800
                                : FontWeight.w600,
                            fontSize: 14.sp,
                            fontFamily: 'Almarai',
                          ),
                        ),
                      ),
                    )
                    .animate(
                      target: isSelected ? 1 : 0,
                      onPlay: (controller) => controller.repeat(reverse: true),
                    )
                    .shimmer(
                      duration: 2.seconds,
                      color: Colors.white.withOpacity(0.05),
                    ),
          ),
        ),
      ),
    );
  }
}
