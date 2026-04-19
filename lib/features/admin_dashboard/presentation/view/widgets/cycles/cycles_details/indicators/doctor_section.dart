import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../../routing/all_routes_imports.dart';

class DoctorSection extends StatelessWidget {
  const DoctorSection({
    super.key,
    required this.selectedDoctor,
    required this.dropdownOpen,
    required this.onToggle,
    required this.onSelect,
  });

  final UserManagementModel? selectedDoctor;
  final bool dropdownOpen;
  final VoidCallback onToggle;
  final Function(UserManagementModel) onSelect;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsersCubit, UsersState>(
      builder: (context, state) {
        final doctors = state is UsersSuccess
            ? state.users.where((u) => u.role == 'doctor').toList()
            : <UserManagementModel>[];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionLabel(title: 'Doctor'),
            SizedBox(height: 8.h),
            CustomDropdown(
              hint: 'Select Doctor',
              selectedDoctor: selectedDoctor,
              doctors: doctors,
              isOpen: dropdownOpen,
              onToggle: onToggle,
              onSelect: onSelect,
            ),
          ],
        );
      },
    );
  }
}
