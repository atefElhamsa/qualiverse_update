import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';

class UserManagementToolbar extends StatelessWidget {
  final TextEditingController searchController;
  final String selectedRole;
  final Function(String) onSearchChanged, onRoleChanged;
  final List<String> roles;

  const UserManagementToolbar({
    super.key,
    required this.searchController,
    required this.selectedRole,
    required this.onSearchChanged,
    required this.onRoleChanged,
    required this.roles,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: [_buildSearchField(), _buildRoleDropdown()],
    );
  }

  Widget _buildSearchField() {
    return SizedBox(
      width: 180,
      height: 40,
      child: TextField(
        controller: searchController,
        onChanged: onSearchChanged,
        decoration: InputDecoration(
          hintText: 'searchUser'.tr(),
          hintStyle: const TextStyle(fontSize: 13, color: Colors.grey),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12),
          border: _border(),
          enabledBorder: _border(),
          focusedBorder: _border(color: AppColors.tooltipBehavior),
        ),
      ),
    );
  }

  Widget _buildRoleDropdown() {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFCCCCCC)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedRole,
          icon: const Icon(Icons.keyboard_arrow_down, size: 18),
          style: const TextStyle(fontSize: 13, color: Color(0xFF333333)),
          items: roles
              .map(
                (role) => DropdownMenuItem(
                  value: role,
                  child: Text(
                    role == 'All' ? 'all'.tr() : ("${role}Role").tr(),
                  ),
                ),
              )
              .toList(),
          onChanged: (val) => onRoleChanged(val!),
        ),
      ),
    );
  }

  OutlineInputBorder _border({Color color = const Color(0xFFCCCCCC)}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: color),
    );
  }
}
