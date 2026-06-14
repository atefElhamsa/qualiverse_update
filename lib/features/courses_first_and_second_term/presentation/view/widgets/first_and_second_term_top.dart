import 'package:flutter/material.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';
import 'package:qualiverse/features/all_features_imports/all_features_imports.dart';

class FirstTermTop extends StatelessWidget {
  final bool isDisabled;
  const FirstTermTop({super.key, this.isDisabled = false});

  @override
  Widget build(BuildContext context) {
    final inherited = HomeBodyInherited.of(context);
    final isDrawerVisible = inherited.isDrawerVisible;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: !isDrawerVisible
              ? CustomScaffoldTop(
                  controller: inherited.controller,
                  isDisabled: isDisabled,
                )
              : const SizedBox(height: 150),
        ),
      ],
    );
  }
}
