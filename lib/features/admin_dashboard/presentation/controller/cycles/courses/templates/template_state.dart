import 'package:qualiverse/routing/all_routes_imports.dart';

sealed class TemplateState {}

class TemplateInitial extends TemplateState {}

class TemplateLoading extends TemplateState {}

class CreateCourseFromTemplateSuccess extends TemplateState {
  final String message;

  CreateCourseFromTemplateSuccess({required this.message});
}

class CreateNewCourseSuccess extends TemplateState {
  final String message;

  CreateNewCourseSuccess({required this.message});
}

class TemplateLoaded extends TemplateState {
  final List<TemplateModel> templates;
  final TemplateModel? selectedTemplate;

  TemplateLoaded({required this.templates, this.selectedTemplate});
}

class TemplateError extends TemplateState {
  final String message;

  TemplateError({required this.message});
}
