import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../../routing/all_routes_imports.dart';

class DropdownList extends StatelessWidget {
  const DropdownList({
    super.key,
    required this.doctors,
    required this.selectedDoctor,
    required this.onSelect,
    required this.doctorName,
  });

  final List<UserManagementModel> doctors;
  final UserManagementModel? selectedDoctor;
  final Function(UserManagementModel) onSelect;
  final String Function(UserManagementModel?) doctorName;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: 200.h),
      decoration: BoxDecoration(
        border: const Border(
          left: BorderSide(color: AppColors.grey),
          right: BorderSide(color: AppColors.grey),
          bottom: BorderSide(color: AppColors.grey),
        ),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(10.r)),
      ),
      child: ListView.separated(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemCount: doctors.length,
        separatorBuilder: (_, _) => Divider(
          height: 1,
          thickness: 0.5,
          color: AppColors.grey.withOpacity(0.3),
        ),
        itemBuilder: (context, index) {
          final doctor = doctors[index];
          final isSelected = selectedDoctor?.id == doctor.id;
          return DropdownItem(
            name: doctorName(doctor),
            isSelected: isSelected,
            onTap: () => onSelect(doctor),
          );
        },
      ),
    );
  }
}
