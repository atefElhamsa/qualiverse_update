import 'package:flutter/material.dart';

import '../../../../../../../../routing/all_routes_imports.dart';

class CustomDropdown extends StatelessWidget {
  const CustomDropdown({
    super.key,
    required this.hint,
    required this.selectedDoctor,
    required this.doctors,
    required this.isOpen,
    required this.onToggle,
    required this.onSelect,
  });

  final String hint;
  final UserManagementModel? selectedDoctor;
  final List<UserManagementModel> doctors;
  final bool isOpen;
  final VoidCallback onToggle;
  final Function(UserManagementModel) onSelect;

  String doctorName(UserManagementModel? doctor) =>
      doctor != null ? '${doctor.firstName} ${doctor.lastName}' : '';

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        DropdownTrigger(
          label: selectedDoctor != null ? doctorName(selectedDoctor) : hint,
          isPlaceholder: selectedDoctor == null,
          isOpen: isOpen,
          onTap: onToggle,
        ),
        if (isOpen)
          DropdownList(
            doctors: doctors,
            selectedDoctor: selectedDoctor,
            onSelect: onSelect,
            doctorName: doctorName,
          ),
      ],
    );
  }
}
