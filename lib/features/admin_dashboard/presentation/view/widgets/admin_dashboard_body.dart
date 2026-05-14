import 'package:flutter/material.dart';

import '../../../../../routing/all_routes_imports.dart';

class AdminDashboardBody extends StatelessWidget {
  const AdminDashboardBody({super.key});

  @override
  Widget build(BuildContext context) {
    final isDrawerVisible = HomeBodyInherited.of(context).isDrawerVisible;
    return CustomScaffoldSetting(
      widget: LayoutBuilder(
        builder: (context, constraints) {
          return SizedBox(
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!isDrawerVisible) const SideBarAdminWidget(),
                const Expanded(child: AdminDashboardContent()),
              ],
            ),
          );
        },
      ),
    );
  }
}
