import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../routing/all_routes_imports.dart';

class SettingContent extends StatelessWidget {
  const SettingContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingCubit, SettingState>(
      builder: (context, selectedIndex) {
        final settingCubit = SettingCubit.get(context);
        return IndexedStack(
          index: settingCubit.selectedIndex,
          children: const [
            AccountSettingsContent(),
            NotificationSettingsContent(),
            LanguageSettingsContent(),
            HelpSettingsContent(),
          ],
        );
      },
    );
  }
}
