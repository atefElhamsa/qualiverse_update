import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class UserManagementTable extends StatelessWidget {
  final List<UserManagementModel> users;

  const UserManagementTable({super.key, required this.users});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const UserTableHeader(),
          if (users.isEmpty)
            Padding(
              padding: const EdgeInsets.all(24),
              child: Text(
                'noUsersFound'.tr(),
                style: const TextStyle(color: Colors.grey),
              ),
            )
          else
            ...users.asMap().entries.map(
              (e) => UserTableRow(
                user: e.value,
                index: e.key,
                total: users.length,
              ),
            ),
        ],
      ),
    );
  }
}
