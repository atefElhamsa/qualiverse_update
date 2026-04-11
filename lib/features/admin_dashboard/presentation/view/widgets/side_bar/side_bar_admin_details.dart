import 'package:flutter/material.dart';

import '../../../../../../routing/all_routes_imports.dart';

class SideBarAdminDetails extends StatelessWidget {
  const SideBarAdminDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [const SideBarAdminTop(), const SideBarAdminList()],
    );
  }
}
