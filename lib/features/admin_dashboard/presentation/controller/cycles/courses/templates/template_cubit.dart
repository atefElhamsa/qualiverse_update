import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class TemplateCubit extends Cubit<TemplateState> {
  TemplateCubit() : super(TemplateInitial());

  List<TemplateModel> templates = [];
  TemplateModel? selectedTemplate;

  static TemplateCubit get(BuildContext context) => BlocProvider.of(context);

  Future<void> fetchTemplates() async {
    templates = [];
    selectedTemplate = null;
    emit(TemplateLoading());
    try {
      final data = await TemplatesService.getTemplates();
      templates = data;
      emit(
        TemplateLoaded(
          templates: templates,
          selectedTemplate: selectedTemplate,
        ),
      );
    } catch (e) {
      final msg = e.toString();
      if (msg.contains('No Internet')) {
        emit(TemplateError(message: 'Check your internet connection'));
      } else if (msg.contains('Unauthorized')) {
        await LoginStorage.clear();
        reset();
        emit(TemplateError(message: 'Session expired, please login again'));
      } else {
        emit(TemplateError(message: 'Something went wrong'));
      }
    }
  }

  void selectTemplate({required TemplateModel template}) {
    selectedTemplate = template;
    emit(
      TemplateLoaded(templates: templates, selectedTemplate: selectedTemplate),
    );
  }

  Future<void> createCourseFromTemplate({
    required int templateId,
    required int yearId,
    int? departmentId,
    required int levelId,
    required int termId,
  }) async {
    emit(TemplateLoading());
    try {
      final message = await TemplatesService.createCourseFromTemplate(
        templateId: templateId,
        yearId: yearId,
        departmentId: departmentId,
        levelId: levelId,
        termId: termId,
      );
      emit(CreateCourseFromTemplateSuccess(message: message));
    } catch (e) {
      final msg = e.toString();
      if (msg.contains('No Internet')) {
        emit(TemplateError(message: 'Check your internet connection'));
      } else if (msg.contains('Unauthorized')) {
        await LoginStorage.clear();
        reset();
        emit(TemplateError(message: 'Session expired, please login again'));
      } else {
        emit(TemplateError(message: 'Something went wrong'));
      }
    }
  }

  Future<void> createNewCourse({
    required String nameAr,
    required String nameEn,
    required String code,
    int? departmentId,
    required int levelId,
    required int termId,
    required int yearId,
  }) async {
    emit(TemplateLoading());
    try {
      final message = await TemplatesService.createNewCourse(
        nameAr: nameAr,
        nameEn: nameEn,
        code: code,
        departmentId: departmentId,
        levelId: levelId,
        termId: termId,
        yearId: yearId,
      );
      emit(CreateNewCourseSuccess(message: message));
    } catch (e) {
      final msg = e.toString();
      if (msg.contains('No Internet')) {
        emit(TemplateError(message: 'Check your internet connection'));
      } else if (msg.contains('Unauthorized')) {
        await LoginStorage.clear();
        reset();
        emit(TemplateError(message: 'Session expired, please login again'));
      } else {
        emit(TemplateError(message: 'Something went wrong'));
      }
    }
  }

  void reset() {
    templates = [];
    selectedTemplate = null;
    emit(TemplateInitial());
  }
}
