import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qualiverse/features/ai_report/presentation/view/widgets/ai_report_result_view.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class AiReportResultScreen extends StatelessWidget {
  final AiReportExtractResponse? extractResponse;

  const AiReportResultScreen({super.key, this.extractResponse});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = AiReportCubit();
        if (extractResponse != null) {
          cubit.init(extractResponse!.aiRequestId, extractResponse!.rawJson);
        }
        return cubit;
      },
      child: const AiReportResultView(),
    );
  }
}
