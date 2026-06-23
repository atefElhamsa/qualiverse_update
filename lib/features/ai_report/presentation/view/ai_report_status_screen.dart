import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qualiverse/features/ai_report/presentation/view/widgets/ai_report_status_body.dart';
import 'package:qualiverse/features/all_features_imports/all_features_imports.dart';

class AiReportStatusScreen extends StatelessWidget {
  final int courseId;

  const AiReportStatusScreen({super.key, required this.courseId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AiReportStatusCubit()..fetchStatus(),
      child: MainWrapper(child: AiReportStatusBody(courseId: courseId)),
    );
  }
}
