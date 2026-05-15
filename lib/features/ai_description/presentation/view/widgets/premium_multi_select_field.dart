import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class PremiumMultiSelectField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final List<String> items;
  final IconData icon;
  final String hint;

  const PremiumMultiSelectField({
    super.key,
    required this.label,
    required this.controller,
    required this.items,
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
      readOnly: false,
      suffixIcon: IconButton(
        icon: Icon(
          Icons.arrow_drop_down_circle_outlined,
          color: const Color(0xFF0D47A1).withOpacity(0.6),
          size: 24.sp,
        ),
        onPressed: () {
          _showMultiSelectionBottomSheet(context);
        },
      ),
    );
  }

  void _showMultiSelectionBottomSheet(BuildContext context) {
    List<String> selectedItems = controller.text.isNotEmpty
        ? controller.text.split(RegExp(r',\s*')).where((e) => e.isNotEmpty).toList()
        : [];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      isDismissible: false,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.85,
              ),
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
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 24.w,
                      vertical: 8.h,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            label,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF1A237E),
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(
                            "doneSuccessfully".tr(),
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: const Color(0xFF0D47A1),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    child: ListView(
                      shrinkWrap: true,
                      padding: EdgeInsets.only(bottom: 30.h),
                      children: [
                        ...items.map((item) {
                          final isSelected = selectedItems.contains(item);
                          return ListTile(
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 24.w,
                            ),
                            leading: Checkbox(
                              value: isSelected,
                              activeColor: const Color(0xFF0D47A1),
                              onChanged: (bool? value) {
                                setModalState(() {
                                  if (value == true) {
                                    selectedItems.add(item);
                                  } else {
                                    selectedItems.remove(item);
                                  }
                                  controller.text = selectedItems.join(', ');
                                });
                              },
                            ),
                            title: Text(item),
                            onTap: () {
                              setModalState(() {
                                if (isSelected) {
                                  selectedItems.remove(item);
                                } else {
                                  selectedItems.add(item);
                                }
                                controller.text = selectedItems.join(', ');
                              });
                            },
                          );
                        }),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
