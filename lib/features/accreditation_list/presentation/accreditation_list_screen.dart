import 'package:flutter/widgets.dart';

import 'package:qualiverse/features/all_features_imports/all_features_imports.dart';

class AccreditationListScreen extends StatelessWidget {
  const AccreditationListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MainWrapper(child: AccreditationListBody());
  }
}
