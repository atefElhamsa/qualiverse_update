import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../routing/all_routes_imports.dart';

class MenuOverlay extends StatelessWidget {
  final LayerLink layerLink;
  final VoidCallback onDismiss;
  final ValueChanged<String> onItemSelected;

  const MenuOverlay({
    super.key,
    required this.layerLink,
    required this.onDismiss,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    final locale = context.locale;
    return Positioned.fill(
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: onDismiss,
        child: Stack(
          children: [
            CompositedTransformFollower(
              link: layerLink,
              offset: locale == const Locale('ar')
                  ? const Offset(-100, 60)
                  : const Offset(40, 60),
              child: Material(
                color: AppColors.transparent,
                child: Container(
                  width: 190.w,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColors.colorButtonLight,
                    borderRadius: BorderRadius.circular(16.r),
                    boxShadow: const [
                      BoxShadow(
                        color: AppColors.black26,
                        blurRadius: 12,
                        offset: Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      MenuItem(
                        icon: Icons.create_new_folder,
                        title: 'new_folder'.tr(),
                        onTap: () => onItemSelected('new_folder'.tr()),
                      ),
                      MenuItem(
                        icon: Icons.drive_folder_upload,
                        title: 'upload_folder'.tr(),
                        onTap: () => onItemSelected('upload_folder'.tr()),
                      ),
                      MenuItem(
                        icon: Icons.upload_file,
                        title: 'upload_file'.tr(),
                        onTap: () => onItemSelected('upload_file'.tr()),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
