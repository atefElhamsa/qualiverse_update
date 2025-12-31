import 'package:flutter/widgets.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';
import 'package:qualiverse/features/all_features_imports/all_features_imports.dart';

class AccreditationListTop extends StatelessWidget {
  const AccreditationListTop({super.key});

  @override
  Widget build(BuildContext context) {
    final inherited = HomeBodyInherited.of(context);
    final isDrawerVisible = inherited.isDrawerVisible;
    return !isDrawerVisible 
      ? CustomScaffoldTop(controller: inherited.controller,)
      : const SizedBox(height: 150,);
  }
}