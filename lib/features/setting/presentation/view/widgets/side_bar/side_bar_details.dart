import 'package:flutter/material.dart';

import '../../../../../../routing/all_routes_imports.dart';

class SideBarDetails extends StatelessWidget {
  const SideBarDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(children: [SideBarTop(), SideBarList()]);
  }
}
