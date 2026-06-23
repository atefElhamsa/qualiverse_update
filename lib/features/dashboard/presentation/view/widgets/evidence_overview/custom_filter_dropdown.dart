import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';

class CustomFilterDropdown<T> extends StatelessWidget {
  const CustomFilterDropdown({
    super.key,
    required this.hint,
    required this.items,
    required this.value,
    required this.onChanged,
  });

  final String hint;
  final List<DropdownMenuItem<T>> items;
  final T? value;
  final ValueChanged<T?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor == AppColors.white
            ? AppColors.white
            : AppColors.mainBlack,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.grey.withOpacity(0.15), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          value: value,
          dropdownColor: Theme.of(context).scaffoldBackgroundColor,
          hint: CustomText(
            title: hint,
            textStyle: GoogleFonts.inter(
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
              color:
                  Theme.of(context).textTheme.bodyMedium?.color ??
                  AppColors.mainBlack,
            ),
          ),
          icon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (value != null)
                InkWell(
                  onTap: () => onChanged(null),
                  child: Padding(
                    padding: EdgeInsets.only(right: 8.w),
                    child: Icon(
                      Icons.close_rounded,
                      color: Colors.grey.shade500,
                      size: 20.sp,
                    ),
                  ),
                ),
              Icon(
                Icons.keyboard_arrow_down_rounded,
                color: Colors.blue.shade600,
              ),
            ],
          ),
          isExpanded: true,
          items: items,
          onChanged: onChanged,
        ),
      ),
    );
  }
}
