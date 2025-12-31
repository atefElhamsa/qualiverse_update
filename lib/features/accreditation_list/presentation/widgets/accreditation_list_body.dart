import 'package:flutter/widgets.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';
import 'package:qualiverse/features/all_features_imports/all_features_imports.dart';

class AccreditationListBody extends StatelessWidget {
  const AccreditationListBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomScaffold(
      widget: Column(
        children: [
          AccreditationListTopAndTitle(),
          SizedBox(height: 20),
          MiddleContent(),
          TableWithLine(),
        ],
      ),
    );
  }
}

// الجهاز اإلداري - المعيار الخامس
