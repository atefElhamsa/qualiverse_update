import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/core/utils/app_colors.dart';
import 'package:qualiverse/core/shared_widgets/custom_text.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final Widget content;
  final List<Widget>? actions;
  final double? maxWidth;
  final bool showCloseIcon;
  final EdgeInsetsGeometry? padding;

  const CustomDialog({
    super.key,
    required this.title,
    required this.content,
    this.actions,
    this.maxWidth,
    this.showCloseIcon = true,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth ?? 650.w),
        child: Padding(
          padding: padding ?? EdgeInsets.all(24.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              SizedBox(height: 20.h),
              content,
              if (actions != null && actions!.isNotEmpty) ...[
                SizedBox(height: 24.h),
                _buildActions(context),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          title: title,
          textStyle: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.mainBlack,
          ),
        ),
        if (showCloseIcon)
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.close, size: 24.sp, color: AppColors.mainBlack),
          ),
      ],
    );
  }

  Widget _buildActions(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: actions!.map((action) {
        final index = actions!.indexOf(action);
        return Padding(
          padding: EdgeInsetsDirectional.only(
            start: index == 0 ? 0 : 12.w,
          ),
          child: action,
        );
      }).toList(),
    );
  }
}
