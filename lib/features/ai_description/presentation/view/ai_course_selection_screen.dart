import 'package:flutter/material.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class AiCourseSelectionScreen extends StatelessWidget {
  const AiCourseSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MainWrapper(child: AiCourseSelectionBody());
  }
}
