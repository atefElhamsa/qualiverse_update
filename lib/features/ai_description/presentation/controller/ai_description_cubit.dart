import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'ai_description_state.dart';

class AiDescriptionCubit extends Cubit<AiDescriptionState> {
  AiDescriptionCubit() : super(AiDescriptionInitial()) {
    _initControllers();
  }

  int currentPage = 0;

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

    totalHoursController = TextEditingController();
  }

  void nextPage() {
    if (currentPage < 4) {
      currentPage++;
      emit(AiDescriptionPageChanged(currentPage));
    }
  }

  void previousPage() {
    if (currentPage > 0) {
      currentPage--;
      emit(AiDescriptionPageChanged(currentPage));
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
    return super.close();
  }
}
