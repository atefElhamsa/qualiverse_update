import 'package:flutter/material.dart';
import 'package:qualiverse/features/all_features_imports/all_features_imports.dart';

// DepartmentScreen is a stateless widget that displays the department page.
class DepartmentScreen extends StatelessWidget {
  // Constructor for DepartmentScreen.
  const DepartmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Returns a Scaffold widget containing the DepartmentBody.
    return const MainWrapper(child: DepartmentBody());
  }
}
