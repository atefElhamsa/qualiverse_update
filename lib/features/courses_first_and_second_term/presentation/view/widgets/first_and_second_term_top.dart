import 'package:flutter/material.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';
import 'package:qualiverse/features/all_features_imports/all_features_imports.dart';

class FirstTermTop extends StatelessWidget {
  final bool isDisabled;
  final bool showBackButton;
  const FirstTermTop({super.key, this.isDisabled = false, this.showBackButton = true});

  @override
  Widget build(BuildContext context) {
    final inherited = HomeBodyInherited.of(context);
    final isDrawerVisible = inherited.isDrawerVisible;
    // If drawer is disabled (details pages), hide menu icon and back button.
    final effectiveShowBackButton = inherited.disableDrawer ? false : showBackButton;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: !isDrawerVisible
              ? CustomScaffoldTop(
                  controller: inherited.controller,
                  isDisabled: isDisabled,
                  showBackButton: effectiveShowBackButton,
                )
              : const SizedBox(height: 150),
        ),
      ],
    );
  }
}
