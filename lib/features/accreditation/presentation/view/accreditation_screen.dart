import 'package:flutter/material.dart';
import 'package:qualiverse/features/all_features_imports/all_features_imports.dart';

// AccreditationScreen is a stateless widget that displays the accreditation information.
class AccreditationScreen extends StatelessWidget {
  // Constructor for AccreditationScreen.
  const AccreditationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Builds the UI for the AccreditationScreen.
    return const MainWrapper(child: AccreditationBody());
  }
}
