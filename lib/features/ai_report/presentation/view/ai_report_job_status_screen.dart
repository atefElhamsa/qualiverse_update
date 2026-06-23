import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qualiverse/features/ai_report/presentation/view/widgets/ai_report_job_status_body.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class AiReportJobStatusScreen extends StatelessWidget {
  final String jobId;

  const AiReportJobStatusScreen({super.key, required this.jobId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AiReportJobStatusCubit(jobId)..startPolling(),
      child: const MainWrapper(
        disabledGestures: true,
        child: AiReportJobStatusBody(),
      ),
    );
  }
}
