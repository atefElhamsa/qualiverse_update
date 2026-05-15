import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/service/ai_description_service.dart';
import '../../data/models/ai_course_file_type_model.dart';

part 'ai_description_state.dart';

class WeekControllers {
  final TextEditingController theoretical = TextEditingController(text: "2");
  final TextEditingController training = TextEditingController(text: "2");
  final TextEditingController selfLearning = TextEditingController(text: "4");
  final TextEditingController other = TextEditingController(text: "0");

  void dispose() {
    theoretical.dispose();
    training.dispose();
    selfLearning.dispose();
    other.dispose();
  }
}

class AiDescriptionCubit extends Cubit<AiDescriptionState> {
  AiDescriptionCubit() : super(AiDescriptionInitial()) {
    _initControllers();
  }

  String? generationId;
  bool get isGenerationStarted => generationId != null;

  int currentPage = 0;
  int learningWeeksCount = 15;
  List<WeekControllers> weekControllers = [];

  void addLearningWeek() {
    learningWeeksCount++;
    weekControllers.add(WeekControllers());
    emit(AiDescriptionWeeksUpdated());
  }

  void removeLearningWeek() {
    if (learningWeeksCount > 15) {
      learningWeeksCount--;
      weekControllers.last.dispose();
      weekControllers.removeLast();
      emit(AiDescriptionWeeksUpdated());
    }
  }

  // Basic Info Controllers
  late TextEditingController titleController;
  late TextEditingController codeController;
  late TextEditingController deptController;
  late TextEditingController typeController;
  late TextEditingController levelController;
  late TextEditingController programController;
  late TextEditingController facultyController;
  late TextEditingController uniController;
  late TextEditingController coordinatorController;
  late TextEditingController dateController;

  // Resources Controllers
  late TextEditingController mainRefController;
  late TextEditingController otherRefsController;
  late TextEditingController electronicController;
  late TextEditingController platformsController;
  late TextEditingController otherResController;

  // Facilities Controllers
  late TextEditingController devicesController;
  late TextEditingController suppliesController;
  late TextEditingController softwareController;
  late TextEditingController labsController;
  late TextEditingController virtualLabsController;
  late TextEditingController otherFacController;

  // Schedule Controller
  late TextEditingController scheduleController;
  late TextEditingController totalHoursController;

  void _initControllers() {
    titleController = TextEditingController();
    codeController = TextEditingController();
    deptController = TextEditingController();
    typeController = TextEditingController();
    levelController = TextEditingController();
    programController = TextEditingController();
    facultyController = TextEditingController();
    uniController = TextEditingController();
    coordinatorController = TextEditingController();
    dateController = TextEditingController();

    mainRefController = TextEditingController();
    otherRefsController = TextEditingController();
    electronicController = TextEditingController();
    platformsController = TextEditingController();
    otherResController = TextEditingController();

    devicesController = TextEditingController();
    suppliesController = TextEditingController();
    softwareController = TextEditingController();
    labsController = TextEditingController();
    virtualLabsController = TextEditingController();
    otherFacController = TextEditingController();

    totalHoursController = TextEditingController(text: "3");
    scheduleController = TextEditingController();

    // Init first 2 weeks controllers
    weekControllers = [];
    for (int i = 0; i < learningWeeksCount; i++) {
      weekControllers.add(WeekControllers());
    }
  }

  void nextPage() {
    if (validatePage(currentPage)) {
      if (currentPage < 5) {
        currentPage++;
        emit(AiDescriptionPageChanged(currentPage));
      }
    } else {
      emit(AiDescriptionValidationError("pleaseFillAllFields".tr()));
    }
  }

  void previousPage() {
    if (currentPage > 0) {
      currentPage--;
      emit(AiDescriptionPageChanged(currentPage));
    }
  }

  File? programFile;
  File? templateFile;

  String? pdfUrl;
  String? docxUrl;
  String? pdfName;
  String? docxName;

  void updateProgramFile(File file) {
    programFile = file;
    emit(AiDescriptionFileUpdated());
  }

  void updateTemplateFile(File file) {
    templateFile = file;
    emit(AiDescriptionFileUpdated());
  }

  int get countUploadedFileDone {
    int count = 0;
    if (programFile != null) count++;
    if (templateFile != null) count++;
    return count;
  }

  double get uploadProgress => countUploadedFileDone / 2;

  // Step 1: Just Upload
  Future<void> uploadAiFiles() async {
    if (generationId == null) {
      emit(AiDescriptionUploadError("pleaseClickStartFirst".tr()));
      return;
    }

    if (programFile == null || templateFile == null) {
      emit(AiDescriptionUploadError("pleaseSelectBothFiles".tr()));
      return;
    }

    emit(AiDescriptionUploadLoading());
    try {
      await AiDescriptionService.uploadFiles(
        generationId: generationId!,
        programFile: programFile!,
        templateFile: templateFile!,
      );
      // New state to trigger the dialog in UI
      emit(AiDescriptionUploadSuccess());
    } catch (e) {
      String msg = e.toString().replaceFirst('Exception: ', '').trim();
      if (msg.isEmpty) msg = 'Upload Failed. Please try again.';
      emit(AiDescriptionUploadError(msg));
    }
  }

  // Step 2: Confirm (Called after user clicks YES in dialog)
  Future<void> confirmAiFiles() async {
    if (generationId == null) return;

    emit(AiDescriptionConfirmLoading());
    try {
      await AiDescriptionService.confirmFiles(generationId: generationId!);
      emit(AiDescriptionConfirmSuccess());
    } catch (e) {
      String msg = e.toString().replaceFirst('Exception: ', '').trim();
      if (msg.isEmpty) msg = 'Confirmation Failed. Please try again.';
      emit(AiDescriptionConfirmError(msg));
    }
  }

  bool isCourseGenerated = false;
  Future<void> submit() async {
    isCourseGenerated = true;
    emit(AiDescriptionSubmitSuccess());
  }

  Future<void> submitCourse() async {
    if (generationId == null) return;
    if (titleController.text.trim().isEmpty) {
      emit(AiDescriptionSubmitError("pleaseEnterCourseName".tr()));
      return;
    }

    emit(AiDescriptionSubmitLoading());
    try {
      await AiDescriptionService.submitCourse(
        generationId: generationId!,
        courseName: titleController.text.trim(),
        courseSchedule: totalHoursController.text.trim(),
      );

      bool isFinished = false;
      while (!isFinished) {
        final statusResult = await AiDescriptionService.checkGenerationStatus(
          generationId: generationId!,
        );
        final status = statusResult.data?.status;

        if (status == 'Generating') {
          await Future.delayed(const Duration(seconds: 20));
        } else if (status == 'Failed' || status == 'Error') {
          throw Exception(statusResult.data?.error ?? 'Generation failed');
        } else if (status == 'Complete') {
          isFinished = true;
          isCourseGenerated = true;
        } else {
          isFinished = true;
          isCourseGenerated = true;
        }
      }

      emit(AiDescriptionSubmitSuccess());
    } catch (e) {
      String msg = e.toString().replaceFirst('Exception: ', '').trim();
      if (msg.isEmpty) msg = 'Submission Failed. Please try again.';
      emit(AiDescriptionSubmitError(msg));
    }
  }

  Future<void> startAiGeneration({required int courseId}) async {
    emit(AiDescriptionStartLoading());
    try {
      final result = await AiDescriptionService.startGeneration(
        courseId: courseId,
      );
      generationId = result.data?.id;
      emit(AiDescriptionStartSuccess(generationId!));
    } catch (e) {
      emit(
        AiDescriptionStartError(
          e.toString().replaceFirst('Exception: ', '').trim(),
        ),
      );
    }
  }

  Future<void> submitDetails() async {
    if (generationId == null) return;

    if (!validatePage(4)) {
      emit(AiDescriptionSubmitDetailsError("pleaseFillAllFields".tr()));
      return;
    }

    emit(AiDescriptionSubmitDetailsLoading());
    try {
      final Map<String, dynamic> data = {
        "basic_info": {
          "course_title": titleController.text.trim(),
          "course_code": codeController.text.trim(),
          "department": deptController.text.trim(),
          "course_type": typeController.text.trim(),
          "academic_level": levelController.text.trim(),
          "academic_program": programController.text.trim(),
          "faculty": facultyController.text.trim(),
          "university": uniController.text.trim(),
          "coordinator": coordinatorController.text.trim(),
          "approval_date": dateController.text.trim(),
        },
        "schedule_info": {
          "total_weekly_hours":
              int.tryParse(totalHoursController.text.trim()) ?? 0,
        },
        "learning_hours_weekly": weekControllers.asMap().entries.map((entry) {
          int index = entry.key;
          WeekControllers controllers = entry.value;
          return {
            "week": index + 1,
            "theoretical":
                int.tryParse(controllers.theoretical.text.trim()) ?? 0,
            "training": int.tryParse(controllers.training.text.trim()) ?? 0,
            "self_learning":
                int.tryParse(controllers.selfLearning.text.trim()) ?? 0,
            "other": int.tryParse(controllers.other.text.trim()) ?? 0,
          };
        }).toList(),
        "resources": {
          "main_reference": mainRefController.text.trim(),
          "other_references": otherRefsController.text.trim(),
          "electronic_sources": electronicController.text.trim(),
          "learning_platforms": platformsController.text.trim(),
          "other": otherResController.text.trim(),
        },
        "facilities": {
          "devices": devicesController.text.trim(),
          "supplies": suppliesController.text.trim(),
          "programs": softwareController.text.trim(),
          "skill_labs": labsController.text.trim(),
          "virtual_labs": virtualLabsController.text.trim(),
          "other": otherFacController.text.trim(),
        },
      };

      final result = await AiDescriptionService.submitDetails(
        generationId: generationId!,
        data: data,
      );
      if (result.isSuccess) {
        // Move to the download step
        currentPage = 5;
        emit(AiDescriptionSubmitDetailsSuccess());
        emit(AiDescriptionPageChanged(currentPage));

        // Fetch URLs for the download step
        getGeneratedFileUrls();
      } else {
        emit(
          AiDescriptionSubmitDetailsError(
            result.error?.description ?? "Submission failed",
          ),
        );
      }
    } catch (e) {
      emit(
        AiDescriptionSubmitDetailsError(
          e.toString().replaceFirst('Exception: ', '').trim(),
        ),
      );
    }
  }

  bool validatePage(int page) {
    switch (page) {
      case 0:
        return titleController.text.trim().isNotEmpty &&
            codeController.text.trim().isNotEmpty &&
            deptController.text.trim().isNotEmpty &&
            typeController.text.trim().isNotEmpty &&
            levelController.text.trim().isNotEmpty &&
            programController.text.trim().isNotEmpty &&
            facultyController.text.trim().isNotEmpty &&
            uniController.text.trim().isNotEmpty &&
            coordinatorController.text.trim().isNotEmpty &&
            dateController.text.trim().isNotEmpty;
      case 1:
        return totalHoursController.text.trim().isNotEmpty;
      case 2:
        for (var controller in weekControllers) {
          if (controller.theoretical.text.trim().isEmpty ||
              controller.training.text.trim().isEmpty ||
              controller.selfLearning.text.trim().isEmpty) {
            return false;
          }
        }
        return true;
      case 3:
        return mainRefController.text.trim().isNotEmpty &&
            otherRefsController.text.trim().isNotEmpty &&
            electronicController.text.trim().isNotEmpty &&
            platformsController.text.trim().isNotEmpty;
      case 4:
        return devicesController.text.trim().isNotEmpty &&
            suppliesController.text.trim().isNotEmpty &&
            softwareController.text.trim().isNotEmpty &&
            labsController.text.trim().isNotEmpty &&
            virtualLabsController.text.trim().isNotEmpty;
      default:
        return true;
    }
  }

  Future<void> getGeneratedFileUrls() async {
    if (generationId == null) return;
    try {
      final docxRes = await AiDescriptionService.downloadFiles(
        generationId: generationId!,
        fileType: 0,
      );
      final pdfRes = await AiDescriptionService.downloadFiles(
        generationId: generationId!,
        fileType: 1,
      );

      if (docxRes.isSuccess && docxRes.data != null) {
        docxUrl = docxRes.data!.url;
        docxName = docxRes.data!.fileName;
      }
      if (pdfRes.isSuccess && pdfRes.data != null) {
        pdfUrl = pdfRes.data!.url;
        pdfName = pdfRes.data!.fileName;
      }
      emit(AiDescriptionFileUpdated());
    } catch (e) {
      // Handle error
    }
  }

  Future<void> downloadFile(int fileType) async {
    if (generationId == null) return;
    emit(AiDescriptionDownloadLoading());
    try {
      final result = await AiDescriptionService.downloadFiles(
        generationId: generationId!,
        fileType: fileType,
      );
      if (result.isSuccess && result.data != null) {
        emit(AiDescriptionDownloadSuccess(result.data!.url));
      } else {
        emit(AiDescriptionDownloadError("Download failed"));
      }
    } catch (e) {
      emit(AiDescriptionDownloadError(e.toString()));
    }
  }

  Future<void> uploadCustomFile({required File docx, required File pdf}) async {
    if (generationId == null) return;
    emit(AiDescriptionCustomUploadLoading());
    try {
      final result = await AiDescriptionService.uploadCustomDescription(
        generationId: generationId!,
        docxFile: docx,
        pdfFile: pdf,
      );
      if (result.isSuccess) {
        emit(AiDescriptionCustomUploadSuccess());
        // After successful upload, refresh URLs
        getGeneratedFileUrls();
      } else {
        emit(AiDescriptionCustomUploadError("Upload failed"));
      }
    } catch (e) {
      emit(AiDescriptionCustomUploadError(e.toString()));
    }
  }

  Future<void> confirmFinal() async {
    if (generationId == null || docxUrl == null || pdfUrl == null) {
      emit(AiDescriptionFinalConfirmError("Please ensure files are ready"));
      return;
    }
    emit(AiDescriptionFinalConfirmLoading());
    try {
      final result = await AiDescriptionService.confirmGeneration(
        generationId: generationId!,
        docxUrl: docxUrl!,
        pdfUrl: pdfUrl!,
      );
      if (result.isSuccess) {
        emit(
          AiDescriptionFinalConfirmSuccess(
            result.data ?? "Description stored successfully",
          ),
        );
      } else {
        emit(AiDescriptionFinalConfirmError("Confirmation failed"));
      }
    } catch (e) {
      emit(AiDescriptionFinalConfirmError(e.toString()));
    }
  }

  Future<void> getFileTypes() async {
    emit(AiDescriptionFileTypesLoading());
    try {
      final types = await AiDescriptionService.getCourseFileTypes();
      emit(AiDescriptionFileTypesSuccess(types));
    } catch (e) {
      emit(AiDescriptionFileTypesError(e.toString()));
    }
  }

  @override
  Future<void> close() {
    titleController.dispose();
    codeController.dispose();
    deptController.dispose();
    typeController.dispose();
    levelController.dispose();
    programController.dispose();
    facultyController.dispose();
    uniController.dispose();
    coordinatorController.dispose();
    dateController.dispose();

    mainRefController.dispose();
    otherRefsController.dispose();
    electronicController.dispose();
    platformsController.dispose();
    otherResController.dispose();

    devicesController.dispose();
    suppliesController.dispose();
    softwareController.dispose();
    labsController.dispose();
    virtualLabsController.dispose();
    otherFacController.dispose();

    totalHoursController.dispose();
    for (var controller in weekControllers) {
      controller.dispose();
    }
    return super.close();
  }
}
