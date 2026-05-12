import 'package:flutter/material.dart';
import 'package:qualiverse/features/all_features_imports/all_features_imports.dart';

class AiDescriptionScreen extends StatelessWidget {
  final int courseId;
  const AiDescriptionScreen({super.key, required this.courseId});

  @override
  Widget build(BuildContext context) {
    return MainWrapper(child: AiDescriptionBody(courseId: courseId));
  }
}
