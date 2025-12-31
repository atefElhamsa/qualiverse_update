import 'package:flutter/material.dart';
import 'package:qualiverse/features/all_features_imports/all_features_imports.dart';

class AiDescriptionScreen extends StatelessWidget {
  const AiDescriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MainWrapper(child: AiDescriptionBody());
  }
}
