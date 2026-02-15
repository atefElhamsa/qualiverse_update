import 'package:flutter/material.dart';

import '../../../../../routing/all_routes_imports.dart';

class SettingBody extends StatelessWidget {
  const SettingBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldSetting(
      widget: LayoutBuilder(
        builder: (context, constraints) {
          return SizedBox(
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SideBarWidget(),
                Expanded(child: SettingContent()),
              ],
            ),
          );
        },
      ),
    );
  }
}
