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
  @override
  void initState() {
    super.initState();
    // Reset the AI description state when starting a new session
    context.read<AiDescriptionCubit>().reset();
  }

  @override
  Widget build(BuildContext context) {
    return MainWrapper(child: AiDescriptionBody(courseId: widget.courseId));
  }
}
