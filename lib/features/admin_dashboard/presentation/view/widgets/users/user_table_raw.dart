import 'package:flutter/material.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class UserTableRow extends StatelessWidget {
  final UserManagementModel user;
  final int index;
  final int total;

  const UserTableRow({
    super.key,
    required this.user,
    required this.index,
    required this.total,
  });

  static const cellStyle = TextStyle(fontSize: 14);
  static const dividerColor = Color(0xFFEEEEEE);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            children: [
              Expanded(
                child: CustomText(title: user.fullName, textStyle: cellStyle),
              ),
              Expanded(
                child: CustomText(
                  title: user.email,
                  textAlign: TextAlign.center,
                  textStyle: cellStyle,
                ),
              ),
              Expanded(
                child: CustomText(
                  title: user.role,
                  textAlign: TextAlign.center,
                  textStyle: cellStyle,
                ),
              ),
              Expanded(
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      final cubit = UsersCubit.get(context);
                      if (user.isActive) {
                        cubit.deactivateUser(id: user.id);
                      } else {
                        cubit.activateUser(id: user.id);
                      }
                    },
                    child: UserStatusBadge(status: user.status),
                  ),
                ),
              ),
            ],
          ),
        ),
        if (index < total - 1) const Divider(height: 1, color: dividerColor),
      ],
    );
  }
}
