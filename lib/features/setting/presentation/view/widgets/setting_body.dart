import 'package:flutter/material.dart';

import '../../../../../routing/all_routes_imports.dart';

class SettingBody extends StatelessWidget {
  const SettingBody({super.key});

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
              children: [
                if (!isDrawerVisible) const SideBarWidget(),
                const Expanded(child: SettingContent()),
              ],
            ),
          );
        },
      ),
    );
  }
}
