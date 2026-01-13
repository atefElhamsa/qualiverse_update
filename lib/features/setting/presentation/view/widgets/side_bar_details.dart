import 'package:flutter/material.dart';

import '../../../../../routing/all_routes_imports.dart';

class SideBarDetails extends StatelessWidget {
  const SideBarDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      // mainAxisAlignment: MainAxisAlignment.start,
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [SideBarTop(), SideBarList()],
    );
  }
}
