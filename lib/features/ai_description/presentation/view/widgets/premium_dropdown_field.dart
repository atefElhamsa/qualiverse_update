import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class PremiumDropdownField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final List<String> items;
  final ValueChanged<String> onChanged;
  final IconData icon;
  final String hint;

  const PremiumDropdownField({
    super.key,
    required this.label,
    required this.controller,
    required this.items,
    required this.onChanged,
    required this.icon,
    required this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return PremiumInputField(
      label: label,
      controller: controller,
      icon: icon,
      hint: hint,
      readOnly: true,
      onTap: () {
        _showSelectionBottomSheet(context);
      },
    );
  }

  void _showSelectionBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 12.h),
              Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              SizedBox(height: 20.h),
              ...items.map((item) {
                final isSelected = item == controller.text;
                return ListTile(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 24.w,
                    vertical: 4.h,
                  ),
                  leading: Icon(
                    isSelected
                        ? Icons.radio_button_checked_rounded
                        : Icons.radio_button_off_rounded,
                    color: isSelected ? const Color(0xFF0D47A1) : Colors.grey,
                  ),
                  title: Text(
                    item,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.w500,
                      color: isSelected
                          ? const Color(0xFF0D47A1)
                          : const Color(0xFF1A237E),
                    ),
                  ),
                  onTap: () {
                    onChanged(item);
                    Navigator.pop(context);
                  },
                );
              }),
              SizedBox(height: 30.h),
            ],
          ),
        );
      },
    );
  }
}
