import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:qualiverse/features/all_features_imports/all_features_imports.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  late SettingCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = SettingCubit.get(context);
  }

  @override
  void dispose() {
    super.dispose();
    cubit.changePage(SettingsPage.account);
  }

  @override
  Widget build(BuildContext context) {
    final _ = context.locale;
    return const MainWrapper(child: SettingBody());
  }
}
