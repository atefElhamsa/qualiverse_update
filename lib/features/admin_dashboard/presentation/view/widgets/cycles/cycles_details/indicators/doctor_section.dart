import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../../routing/all_routes_imports.dart';
import 'package:easy_localization/easy_localization.dart';

class DoctorSection extends StatelessWidget {
  const DoctorSection({
    super.key,
    required this.selectedDoctor,
    required this.dropdownOpen,
    required this.onToggle,
    required this.onSelect,
    this.allowedRoles = const ['doctor'],
  });

  final UserManagementModel? selectedDoctor;
  final bool dropdownOpen;
  final VoidCallback onToggle;
  final Function(UserManagementModel) onSelect;
  final List<String> allowedRoles;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsersCubit, UsersState>(
      builder: (context, state) {
        final doctors = state is UsersSuccess
            ? state.users
                  .where(
                    (u) => u.roles.any(
                      (userRole) => allowedRoles.any(
                        (allowedRole) =>
                            allowedRole.toLowerCase() == userRole.toLowerCase(),
                      ),
                    ),
                  )
                  .toList()
            : <UserManagementModel>[];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionLabel(title: 'doctor'.tr()),
            SizedBox(height: 8.h),
            CustomDropdown(
              hint: 'selectDoctor'.tr(),
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
