import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';
import 'package:qualiverse/features/all_features_imports/all_features_imports.dart';

class SettingFields extends StatelessWidget {
  const SettingFields({
    super.key,
    required this.selectedLang,
    required this.onLanguageChanged,
  });

  final String selectedLang;
  final Function(String) onLanguageChanged;

  @override
  Widget build(BuildContext context) {
    final settingCubit = SettingCubit.get(context);
    return Column(
      children: [
        CustomFieldReadOnly(
          title: "email".tr(),
          data: settingCubit.email ?? "",
        ),
        CustomFieldReadOnly(
          title: "password".tr(),
          data: settingCubit.password ?? "",
          obscureText: true,
        ),
        CustomDropButtonAndTitle(
          dropButtonModel: DropButtonModel(
            selectedData: selectedLang == "en" ? "English" : "العربية",
            listOfData: ["English", "العربية"],
            hintText: selectedLang == "en" ? "English" : "العربية",
            onChanged: (value) {
              if (value == "English") {
                onLanguageChanged("en");
              } else {
                onLanguageChanged("ar");
              }
            },
          ),
          title: "selectLanguage".tr(),
        ),
      ],
    );
  }
}
