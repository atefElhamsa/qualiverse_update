import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qualiverse/features/all_features_imports/all_features_imports.dart';

class AiReportScreen extends StatelessWidget {
  const AiReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // extra = {'provider': String?, 'courseNature': String?, 'courseId': int}
    final extra = GoRouterState.of(context).extra as Map<String, dynamic>?;
    final String? provider = extra?['provider'] as String?;
    final String? courseNature = extra?['courseNature'] as String?;
    final int courseId = extra?['courseId'] as int;

    return MainWrapper(
      child: AiReportBody(
        selectedProvider: provider,
        selectedCourseNature: courseNature,
        courseId: courseId,
      ),
    );
  }
}
