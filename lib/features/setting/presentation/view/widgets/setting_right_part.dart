import 'package:flutter/material.dart';
import 'package:qualiverse/features/setting/setting_imports/setting_imports.dart';

class SettingRightPart extends StatelessWidget {
  const SettingRightPart({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        LogOutButton(),
        ProfileCardWidget(),
        SizedBox(height: 16),
        InfoListWidget(),
      ],
    );
  }
}
