import 'package:flutter/material.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';
import 'package:qualiverse/features/all_features_imports/all_features_imports.dart';

// Define a stateless widget for the AI main body.
class AiMainBody extends StatelessWidget {
  // Constructor for AiMainBody.
  const AiMainBody({super.key});

  @override
  Widget build(BuildContext context) {
    // Return a CustomScaffold widget.
    return CustomScaffold(
      // Define the child widget of the CustomScaffold.
      widget: Column(
        // Align children to the start of the cross axis.
        crossAxisAlignment: CrossAxisAlignment.start,
        // Align children to the center of the main axis.
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Display the custom scaffold top section.
          const AiMainTopAndTitle(),
          // Center the following Image.asset widget.
          Center(
            child: Image.asset(AppImages.accreditationImage, fit: BoxFit.cover),
          ),
          // Add a SizedBox for vertical spacing.
          const SizedBox(height: 30),
          // Display the AI main buttons.
          const AiMainButtons(),
        ],
      ),
    );
  }
}
