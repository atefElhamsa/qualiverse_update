import 'package:flutter/material.dart';
import 'package:qualiverse/features/setting/setting_imports/setting_imports.dart';

class InfoListWidget extends StatelessWidget {
  const InfoListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: infoItems
          .map((item) => InfoItemWidget(infoItemModel: item))
          .toList(),
    );
  }
}
