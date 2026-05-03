import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/core/utils/app_colors.dart';

class CustomBaseDropDown<T> extends StatelessWidget {
  final List<T> items;
  final T? value;
  final String hint;
  final String Function(T) itemLabelBuilder;
  final dynamic Function(T) itemValueBuilder;
  final ValueChanged<dynamic>? onChanged;
  final double? height;
  final bool isExpanded;
  final bool isLoading;
  final Widget? prefixIcon;
  final bool isDisabled;

  const CustomBaseDropDown({
    super.key,
    required this.items,
    required this.itemLabelBuilder,
    required this.itemValueBuilder,
    this.value,
    required this.hint,
    this.onChanged,
    this.height,
    this.isExpanded = true,
    this.isLoading = false,
    this.prefixIcon,
    this.isDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 50.h,
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      decoration: BoxDecoration(
        color: isDisabled ? Colors.grey.shade100 : AppColors.white,
        border: Border.all(color: AppColors.grey.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<dynamic>(
          isExpanded: isExpanded,
          value: value != null ? itemValueBuilder(value as T) : null,
          hint: Row(
            children: [
              if (prefixIcon != null) ...[
                prefixIcon!,
                SizedBox(width: 8.w),
              ],
              Expanded(
                child: Text(
                  isLoading ? 'Loading...' : hint,
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: isDisabled ? Colors.grey.shade400 : AppColors.grey,
                    overflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
          icon: isLoading
              ? SizedBox(
                  width: 15.sp,
                  height: 15.sp,
                  child: const CircularProgressIndicator(strokeWidth: 2),
                )
              : Icon(Icons.keyboard_arrow_down,
                  color: isDisabled ? Colors.grey.shade400 : AppColors.mainBlack,
                  size: 22.sp),
          style: TextStyle(
            fontSize: 15.sp,
            color: isDisabled ? Colors.grey.shade400 : AppColors.mainBlack,
            fontWeight: FontWeight.w500,
          ),
          items: items.map((item) {
            final val = itemValueBuilder(item);
            final label = itemLabelBuilder(item);
            return DropdownMenuItem<dynamic>(
              value: val,
              child: Text(
                label,
                overflow: TextOverflow.ellipsis,
              ),
            );
          }).toList(),
          onChanged: isDisabled ? null : onChanged,
        ),
      ),
    );
  }
}
