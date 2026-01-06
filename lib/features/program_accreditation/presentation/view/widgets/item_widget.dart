import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class ItemWidget extends StatelessWidget {
  const ItemWidget({
    super.key,
    required this.itemModel,
    this.onTap,
    required this.accreditationModel,
  });

  final ItemModel itemModel;
  final AccreditationModel accreditationModel;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final locale = WidgetsBinding.instance.platformDispatcher.locale;
    final bool isArabic = locale.languageCode == 'ar';

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 267.w,
        height: 100.h,
        child: Card(
          color: Theme.of(context).colorScheme.onSecondaryFixed,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.r),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (!isArabic) buildIcon(context),

                if (!isArabic) SizedBox(width: 12.w),

                Expanded(
                  child: Text(
                    accreditationModel.localizedName(context),
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall!.copyWith(height: 1.25),
                  ),
                ),

                if (isArabic) SizedBox(width: 12.w),

                if (isArabic) buildIcon(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildIcon(BuildContext context) {
    return Image.asset(
      Theme.of(context).scaffoldBackgroundColor == AppColors.white
          ? itemModel.imageLight
          : itemModel.imageDark,
      height: 48.h,
      width: 48.w,
      fit: BoxFit.contain,
    );
  }
}
