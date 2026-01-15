import 'package:flutter/material.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class ContainerLanguage extends StatelessWidget {
  const ContainerLanguage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomContainerSetting(
      widget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ContainerLanguageTopAndButton(),
          SizedBox(height: 20),
          ListLanguages(),
        ],
      ),
    );
  }
}
