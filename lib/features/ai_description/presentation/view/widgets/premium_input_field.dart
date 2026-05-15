import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PremiumInputField extends StatelessWidget {
  final String label;
  final TextEditingController? controller;
  final IconData icon;
  final String hint;
  final double? fontSize;
  final double? labelFontSize;
  final VoidCallback? onTap;
  final bool readOnly;
  final int? maxLines;
  final Widget? suffixIcon;

  const PremiumInputField({
    super.key,
    required this.label,
    this.controller,
    required this.icon,
    required this.hint,
    this.fontSize,
    this.labelFontSize,
    this.onTap,
    this.readOnly = false,
    this.maxLines = 1,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 8.w, bottom: 4.h),
            child: Text(
              label,
              style: TextStyle(
                color: const Color(0xFF0D47A1).withOpacity(0.8),
                fontWeight: FontWeight.bold,
                fontSize: labelFontSize ?? 14.sp,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF0D47A1).withOpacity(0.06),
                  blurRadius: 15,
                  offset: const Offset(0, 6),
                ),
              ],
              border: Border.all(
                color: const Color(0xFF0D47A1).withOpacity(0.1),
                width: 1.2,
              ),
            ),
            child: TextFormField(
              controller: controller,
              readOnly: readOnly,
              maxLines: maxLines,
              onTap: onTap,
              style: TextStyle(
                fontSize: fontSize ?? 16.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF1A237E),
              ),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: TextStyle(
                  color: Colors.grey.shade400,
                  fontSize: (fontSize ?? 16.sp) - 2.sp,
                  fontWeight: FontWeight.w400,
                ),
                prefixIcon: Icon(
                  icon,
                  color: const Color(0xFF0D47A1).withOpacity(0.6),
                  size: (fontSize ?? 16.sp) + 4.sp,
                ),
                suffixIcon: suffixIcon,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 18.w,
                  vertical: 14.h,
                ),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.r),
                  borderSide: const BorderSide(
                    color: Color(0xFF0D47A1),
                    width: 1.5,
                  ),
                ),
                filled: true,
                fillColor: Colors.transparent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
