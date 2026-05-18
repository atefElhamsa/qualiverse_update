import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qualiverse/features/all_features_imports/all_features_imports.dart';

class AiDescriptionScreen extends StatefulWidget {
  final int courseId;
  const AiDescriptionScreen({super.key, required this.courseId});

  @override
  State<AiDescriptionScreen> createState() => _AiDescriptionScreenState();
}

class _AiDescriptionScreenState extends State<AiDescriptionScreen> {
  late final AiDescriptionCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<AiDescriptionCubit>();
    _cubit.reset();
  }

  @override
  void dispose() {
    if (_cubit.isGenerationStarted &&
        _cubit.state is! AiDescriptionConfirmSuccess) {
      _cubit.endGeneration();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MainWrapper(child: AiDescriptionBody(courseId: widget.courseId));
  }
}
