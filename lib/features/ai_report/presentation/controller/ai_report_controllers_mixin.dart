import 'package:flutter/material.dart';

mixin AiReportControllersMixin {
  // ===========================================================================
  // 1. BASIC INFO CONTROLLERS
  // ===========================================================================
  final TextEditingController titleController = TextEditingController();
  final TextEditingController codeController = TextEditingController();
  final TextEditingController yearController = TextEditingController();
  final TextEditingController semesterController = TextEditingController();
  final TextEditingController deptController = TextEditingController();
  final TextEditingController typeController = TextEditingController();
  final TextEditingController levelController = TextEditingController();
  final TextEditingController programController = TextEditingController();
  final TextEditingController facultyController = TextEditingController();
  final TextEditingController uniController = TextEditingController();
  final TextEditingController coordinatorController = TextEditingController();

  // ===========================================================================
  // 2. CREDIT HOURS & STAFF CONTROLLERS
  // ===========================================================================
  final TextEditingController creditHoursController = TextEditingController();
  final TextEditingController numWeeksController = TextEditingController();
  final TextEditingController theoreticalHoursController = TextEditingController();
  final TextEditingController practicalHoursController = TextEditingController();
  final TextEditingController fieldHoursController = TextEditingController();
  final TextEditingController selfHoursController = TextEditingController();
  final TextEditingController otherHoursController = TextEditingController();

  final TextEditingController instructorFulltimeController = TextEditingController(text: "0");
  final TextEditingController instructorParttimeController = TextEditingController(text: "1");
  final TextEditingController taFulltimeController = TextEditingController(text: "0");
  final TextEditingController taParttimeController = TextEditingController(text: "1");

  final TextEditingController topicsNotCoveredController = TextEditingController();
  final TextEditingController teachingMethodChangesController = TextEditingController();

  // ===========================================================================
  // 3. ASSESSMENTS CONTROLLERS
  // ===========================================================================
  final TextEditingController exam1EvalDateController = TextEditingController();
  final TextEditingController exam1DateController = TextEditingController();
  final TextEditingController exam1MarksController = TextEditingController();
  final TextEditingController exam1TypeController = TextEditingController();
  final TextEditingController exam1ClosController = TextEditingController();

  final TextEditingController exam2EvalDateController = TextEditingController();
  final TextEditingController exam2DateController = TextEditingController();
  final TextEditingController exam2MarksController = TextEditingController();
  final TextEditingController exam2TypeController = TextEditingController();
  final TextEditingController exam2ClosController = TextEditingController();

  final TextEditingController midtermEvalDateController = TextEditingController();
  final TextEditingController midtermDateController = TextEditingController();
  final TextEditingController midtermMarksController = TextEditingController();
  final TextEditingController midtermTypeController = TextEditingController();
  final TextEditingController midtermClosController = TextEditingController();

  final TextEditingController practicalEvalDateController = TextEditingController();
  final TextEditingController practicalDateController = TextEditingController();
  final TextEditingController practicalMarksController = TextEditingController();
  final TextEditingController practicalTypeController = TextEditingController();
  final TextEditingController practicalClosController = TextEditingController();

  final TextEditingController oralEvalDateController = TextEditingController();
  final TextEditingController oralDateController = TextEditingController();
  final TextEditingController oralMarksController = TextEditingController();
  final TextEditingController oralTypeController = TextEditingController();
  final TextEditingController oralClosController = TextEditingController();

  final TextEditingController writtenEvalDateController = TextEditingController();
  final TextEditingController writtenDateController = TextEditingController();
  final TextEditingController writtenMarksController = TextEditingController();
  final TextEditingController writtenTypeController = TextEditingController();
  final TextEditingController writtenClosController = TextEditingController();

  final TextEditingController assessmentCommentController = TextEditingController();

  // ===========================================================================
  // 4. EXTRA DATA CONTROLLERS
  // ===========================================================================
  final TextEditingController studentsStartedController = TextEditingController();
  final TextEditingController studentsCompletedController = TextEditingController();
  final TextEditingController studentsAbsentController = TextEditingController();
  final TextEditingController studentsPassedController = TextEditingController();
  final TextEditingController passPercentageController = TextEditingController();
  final TextEditingController studentsFailedController = TextEditingController();
  final TextEditingController failPercentageController = TextEditingController();
  final TextEditingController performanceCommentController = TextEditingController();
  final TextEditingController performanceNotesController = TextEditingController();

  final TextEditingController aPlusCountController = TextEditingController();
  final TextEditingController aPlusPctController = TextEditingController();
  final TextEditingController aCountController = TextEditingController();
  final TextEditingController aPctController = TextEditingController();
  final TextEditingController bPlusCountController = TextEditingController();
  final TextEditingController bPlusPctController = TextEditingController();
  final TextEditingController bCountController = TextEditingController();
  final TextEditingController bPctController = TextEditingController();
  final TextEditingController cPlusCountController = TextEditingController();
  final TextEditingController cPlusPctController = TextEditingController();
  final TextEditingController cCountController = TextEditingController();
  final TextEditingController cPctController = TextEditingController();
  final TextEditingController dPlusCountController = TextEditingController();
  final TextEditingController dPlusPctController = TextEditingController();
  final TextEditingController dCountController = TextEditingController();
  final TextEditingController dPctController = TextEditingController();

  final TextEditingController surveyMeansController = TextEditingController();
  final TextEditingController surveyTimingController = TextEditingController();
  final TextEditingController surveyParticipantsController = TextEditingController();
  final TextEditingController surveyPctController = TextEditingController();
  final TextEditingController satisfaction1Controller = TextEditingController();
  final TextEditingController satisfaction2Controller = TextEditingController();
  final TextEditingController satisfaction3Controller = TextEditingController();
  final TextEditingController dissatisfaction1Controller = TextEditingController();
  final TextEditingController dissatisfaction2Controller = TextEditingController();
  final TextEditingController dissatisfaction3Controller = TextEditingController();

  final TextEditingController instructorReflectionController = TextEditingController();
  final TextEditingController uncompletedActionsController = TextEditingController();
  final TextEditingController approvalDateController = TextEditingController();
  final TextEditingController approvalAttachmentController = TextEditingController();

  // ===========================================================================
  // DISPOSE ALL CONTROLLERS
  // ===========================================================================
  void disposeAllControllers() {
    titleController.dispose();
    codeController.dispose();
    yearController.dispose();
    semesterController.dispose();
    deptController.dispose();
    typeController.dispose();
    levelController.dispose();
    programController.dispose();
    facultyController.dispose();
    uniController.dispose();
    coordinatorController.dispose();

    creditHoursController.dispose();
    numWeeksController.dispose();
    theoreticalHoursController.dispose();
    practicalHoursController.dispose();
    fieldHoursController.dispose();
    selfHoursController.dispose();
    otherHoursController.dispose();
    instructorFulltimeController.dispose();
    instructorParttimeController.dispose();
    taFulltimeController.dispose();
    taParttimeController.dispose();
    topicsNotCoveredController.dispose();
    teachingMethodChangesController.dispose();

    exam1EvalDateController.dispose();
    exam1DateController.dispose();
    exam1MarksController.dispose();
    exam1TypeController.dispose();
    exam1ClosController.dispose();
    exam2EvalDateController.dispose();
    exam2DateController.dispose();
    exam2MarksController.dispose();
    exam2TypeController.dispose();
    exam2ClosController.dispose();
    midtermEvalDateController.dispose();
    midtermDateController.dispose();
    midtermMarksController.dispose();
    midtermTypeController.dispose();
    midtermClosController.dispose();
    practicalEvalDateController.dispose();
    practicalDateController.dispose();
    practicalMarksController.dispose();
    practicalTypeController.dispose();
    practicalClosController.dispose();
    oralEvalDateController.dispose();
    oralDateController.dispose();
    oralMarksController.dispose();
    oralTypeController.dispose();
    oralClosController.dispose();
    writtenEvalDateController.dispose();
    writtenDateController.dispose();
    writtenMarksController.dispose();
    writtenTypeController.dispose();
    writtenClosController.dispose();
    assessmentCommentController.dispose();

    studentsStartedController.dispose();
    studentsCompletedController.dispose();
    studentsAbsentController.dispose();
    studentsPassedController.dispose();
    passPercentageController.dispose();
    studentsFailedController.dispose();
    failPercentageController.dispose();
    performanceCommentController.dispose();
    performanceNotesController.dispose();

    aPlusCountController.dispose();
    aPlusPctController.dispose();
    aCountController.dispose();
    aPctController.dispose();
    bPlusCountController.dispose();
    bPlusPctController.dispose();
    bCountController.dispose();
    bPctController.dispose();
    cPlusCountController.dispose();
    cPlusPctController.dispose();
    cCountController.dispose();
    cPctController.dispose();
    dPlusCountController.dispose();
    dPlusPctController.dispose();
    dCountController.dispose();
    dPctController.dispose();

    surveyMeansController.dispose();
    surveyTimingController.dispose();
    surveyParticipantsController.dispose();
    surveyPctController.dispose();
    satisfaction1Controller.dispose();
    satisfaction2Controller.dispose();
    satisfaction3Controller.dispose();
    dissatisfaction1Controller.dispose();
    dissatisfaction2Controller.dispose();
    dissatisfaction3Controller.dispose();

    instructorReflectionController.dispose();
    uncompletedActionsController.dispose();
    approvalDateController.dispose();
    approvalAttachmentController.dispose();
  }
}
