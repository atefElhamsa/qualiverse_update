import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qualiverse/features/ai_report/data/models/improvement_plan_form_model.dart';
import 'package:qualiverse/features/ai_report/data/service/ai_report_service.dart';
import 'package:qualiverse/features/ai_report/data/models/instructor_form_model.dart';
import 'package:qualiverse/features/ai_report/presentation/controller/ai_report_controllers_mixin.dart';
import 'ai_report_state.dart';

class AiReportCubit extends Cubit<AiReportState> with AiReportControllersMixin {
  AiReportCubit() : super(AiReportInitial());

  int currentPage = 0;
  Map<String, dynamic> extractedData = {};

  // ===========================================================================
  // 1. INITIALIZATION LOGIC
  // ===========================================================================
  void init(Map<String, dynamic> data) {
    extractedData = data;

    _initBasicInfo(data);
    _initCreditHoursAndStaff(data);
    _initAssessments(data);
    _initExtraData(data);
    _initDynamicLists(data);
  }

  void _initBasicInfo(Map<String, dynamic> data) {
    titleController.text = data['course_title']?.toString() ?? '';
    codeController.text = data['course_code']?.toString() ?? '';
    yearController.text = data['academic_year']?.toString() ?? '';
    semesterController.text = data['semester']?.toString() ?? '';
    deptController.text = data['department']?.toString() ?? '';
    typeController.text = data['course_type']?.toString() ?? '';
    levelController.text = data['level']?.toString() ?? '';
    programController.text = data['program']?.toString() ?? '';
    facultyController.text = data['faculty']?.toString() ?? '';
    uniController.text = data['university']?.toString() ?? '';
    coordinatorController.text = data['coordinator_name']?.toString() ?? '';
  }

  void _initCreditHoursAndStaff(Map<String, dynamic> data) {
    creditHoursController.text = data['credit_hours']?.toString() ?? '';
    numWeeksController.text = data['num_weeks_actual']?.toString() ?? '';
    theoreticalHoursController.text =
        data['total_theoretical_hours']?.toString() ?? '';
    practicalHoursController.text =
        data['total_practical_hours']?.toString() ?? '';
    fieldHoursController.text = data['total_field_hours']?.toString() ?? '';
    selfHoursController.text = data['total_self_hours']?.toString() ?? '';
    otherHoursController.text = data['total_other_hours']?.toString() ?? '';

    instructorFulltimeController.text =
        data['instructor_fulltime']?.toString() ?? '0';
    instructorParttimeController.text =
        data['instructor_parttime']?.toString() ?? '1';
    taFulltimeController.text = data['ta_fulltime']?.toString() ?? '0';
    taParttimeController.text = data['ta_parttime']?.toString() ?? '1';

    topicsNotCoveredController.text =
        data['topics_not_covered']?.toString() ?? '';
    teachingMethodChangesController.text =
        data['teaching_method_changes']?.toString() ?? '';
  }

  void _initAssessments(Map<String, dynamic> data) {
    exam1EvalDateController.text = data['exam1_eval_date']?.toString() ?? '';
    exam1DateController.text = data['exam1_date']?.toString() ?? '';
    exam1MarksController.text = data['exam1_marks']?.toString() ?? '';
    exam1TypeController.text = data['exam1_type']?.toString() ?? '';
    exam1ClosController.text = data['exam1_clos']?.toString() ?? '';

    exam2EvalDateController.text = data['exam2_eval_date']?.toString() ?? '';
    exam2DateController.text = data['exam2_date']?.toString() ?? '';
    exam2MarksController.text = data['exam2_marks']?.toString() ?? '';
    exam2TypeController.text = data['exam2_type']?.toString() ?? '';
    exam2ClosController.text = data['exam2_clos']?.toString() ?? '';

    midtermEvalDateController.text =
        data['midterm_eval_date']?.toString() ?? '';
    midtermDateController.text = data['midterm_date']?.toString() ?? '';
    midtermMarksController.text = data['midterm_marks']?.toString() ?? '';
    midtermTypeController.text = data['midterm_type']?.toString() ?? '';
    midtermClosController.text = data['midterm_clos']?.toString() ?? '';

    practicalEvalDateController.text =
        data['practical_eval_date']?.toString() ?? '';
    practicalDateController.text = data['practical_date']?.toString() ?? '';
    practicalMarksController.text = data['practical_marks']?.toString() ?? '';
    practicalTypeController.text = data['practical_type']?.toString() ?? '';
    practicalClosController.text = data['practical_clos']?.toString() ?? '';

    oralEvalDateController.text = data['oral_eval_date']?.toString() ?? '';
    oralDateController.text = data['oral_date']?.toString() ?? '';
    oralMarksController.text = data['oral_marks']?.toString() ?? '';
    oralTypeController.text = data['oral_type']?.toString() ?? '';
    oralClosController.text = data['oral_clos']?.toString() ?? '';

    writtenEvalDateController.text =
        data['written_eval_date']?.toString() ?? '';
    writtenDateController.text = data['written_date']?.toString() ?? '';
    writtenMarksController.text = data['written_marks']?.toString() ?? '';
    writtenTypeController.text = data['written_type']?.toString() ?? '';
    writtenClosController.text = data['written_clos']?.toString() ?? '';

    assessmentCommentController.text =
        data['assessment_comment']?.toString() ?? '';
  }

  void _initExtraData(Map<String, dynamic> data) {
    // Grades
    studentsStartedController.text = data['students_started']?.toString() ?? '';
    studentsCompletedController.text =
        data['students_completed']?.toString() ?? '';
    studentsAbsentController.text = data['students_absent']?.toString() ?? '';
    studentsPassedController.text = data['students_passed']?.toString() ?? '';
    passPercentageController.text = data['pass_percentage']?.toString() ?? '';
    studentsFailedController.text = data['students_failed']?.toString() ?? '';
    failPercentageController.text = data['fail_percentage']?.toString() ?? '';
    performanceCommentController.text =
        data['performance_comment']?.toString() ?? '';
    performanceNotesController.text =
        data['performance_notes']?.toString() ?? '';

    if (data['grades'] is Map) {
      final g = data['grades'];
      aPlusCountController.text = g['a_plus_count']?.toString() ?? '';
      aPlusPctController.text = g['a_plus_pct']?.toString() ?? '';
      aCountController.text = g['a_count']?.toString() ?? '';
      aPctController.text = g['a_pct']?.toString() ?? '';
      bPlusCountController.text = g['b_plus_count']?.toString() ?? '';
      bPlusPctController.text = g['b_plus_pct']?.toString() ?? '';
      bCountController.text = g['b_count']?.toString() ?? '';
      bPctController.text = g['b_pct']?.toString() ?? '';
      cPlusCountController.text = g['c_plus_count']?.toString() ?? '';
      cPlusPctController.text = g['c_plus_pct']?.toString() ?? '';
      cCountController.text = g['c_count']?.toString() ?? '';
      cPctController.text = g['c_pct']?.toString() ?? '';
      dPlusCountController.text = g['d_plus_count']?.toString() ?? '';
      dPlusPctController.text = g['d_plus_pct']?.toString() ?? '';
      dCountController.text = g['d_count']?.toString() ?? '';
      dPctController.text = g['d_pct']?.toString() ?? '';
    }

    // Surveys
    surveyMeansController.text = data['survey_means']?.toString() ?? '';
    surveyTimingController.text = data['survey_timing']?.toString() ?? '';
    surveyParticipantsController.text =
        data['survey_participants']?.toString() ?? '';
    surveyPctController.text = data['survey_pct']?.toString() ?? '';
    satisfaction1Controller.text = data['satisfaction_1']?.toString() ?? '';
    satisfaction2Controller.text = data['satisfaction_2']?.toString() ?? '';
    satisfaction3Controller.text = data['satisfaction_3']?.toString() ?? '';
    dissatisfaction1Controller.text =
        data['dissatisfaction_1']?.toString() ?? '';
    dissatisfaction2Controller.text =
        data['dissatisfaction_2']?.toString() ?? '';
    dissatisfaction3Controller.text =
        data['dissatisfaction_3']?.toString() ?? '';

    // Reflection
    instructorReflectionController.text =
        data['instructor_reflection']?.toString() ?? '';
    uncompletedActionsController.text =
        data['uncompleted_actions']?.toString() ?? '';
    approvalDateController.text = data['approval_date']?.toString() ?? '';
    approvalAttachmentController.text =
        data['approval_attachment']?.toString() ?? '';
  }

  void _initDynamicLists(Map<String, dynamic> data) {
    if (data['instructors'] is List) {
      final list = data['instructors'] as List;
      if (list.isNotEmpty) {
        instructorsList.clear();
        for (var item in list) {
          if (item is Map) {
            final model = InstructorFormModel();
            model.nameController.text = item['name']?.toString() ?? '';
            model.deptController.text = item['department']?.toString() ?? '';
            model.degreeController.text = item['degree']?.toString() ?? '';
            model.specialtyController.text =
                item['specialty']?.toString() ?? '';
            instructorsList.add(model);
          }
        }
      }
    }
    if (instructorsList.isEmpty) {
      instructorsList.add(InstructorFormModel());
    }

    if (data['improvement_plan'] is List) {
      final list = data['improvement_plan'] as List;
      if (list.isNotEmpty) {
        improvementPlanList.clear();
        for (var item in list) {
          if (item is Map) {
            final model = ImprovementPlanFormModel();
            model.noController.text = item['no']?.toString() ?? '';
            model.pointController.text = item['point']?.toString() ?? '';
            model.actionController.text = item['action']?.toString() ?? '';
            model.methodController.text = item['method']?.toString() ?? '';
            model.notesController.text = item['notes']?.toString() ?? '';
            improvementPlanList.add(model);
          }
        }
      }
    }
    if (improvementPlanList.isEmpty) {
      improvementPlanList.add(ImprovementPlanFormModel());
    }
  }

  // Dynamic Lists
  final List<InstructorFormModel> instructorsList = [InstructorFormModel()];
  final List<ImprovementPlanFormModel> improvementPlanList = [
    ImprovementPlanFormModel(),
  ];

  // ===========================================================================
  // 3. UI STATE MUTATORS
  // ===========================================================================
  void addInstructor() {
    instructorsList.add(InstructorFormModel());
    emit(AiReportInstructorsChanged());
  }

  void removeInstructor(int index) {
    if (instructorsList.length > 1) {
      instructorsList[index].dispose();
      instructorsList.removeAt(index);
      emit(AiReportInstructorsChanged());
    }
  }

  void addImprovementPlan() {
    improvementPlanList.add(ImprovementPlanFormModel());
    emit(AiReportImprovementPlanChanged());
  }

  void removeImprovementPlan(int index) {
    if (improvementPlanList.length > 1) {
      improvementPlanList[index].dispose();
      improvementPlanList.removeAt(index);
      emit(AiReportImprovementPlanChanged());
    }
  }

  void nextPage() {
    if (currentPage < 4) {
      currentPage++;
      emit(AiReportPageChanged(currentPage));
    }
  }

  void previousPage() {
    if (currentPage > 0) {
      currentPage--;
      emit(AiReportPageChanged(currentPage));
    }
  }

  // ===========================================================================
  // 4. SUBMIT REPORT LOGIC
  // ===========================================================================
  Future<void> submitReport() async {
    emit(AiReportLoading());
    try {
      final requestData = Map<String, dynamic>.from(extractedData);

      requestData.addAll(_buildBasicInfoPayload());
      requestData.addAll(_buildHoursAndStaffPayload());
      requestData.addAll(_buildAssessmentsPayload());
      requestData.addAll(_buildExtraDataPayload());
      requestData.addAll(_buildDynamicListsPayload());

      final responseBody = await AiReportService.submitReport(requestData);

      final dataObj = responseBody['data'];
      String jobId = '';
      if (dataObj is Map) {
        jobId = dataObj['job_id']?.toString() ?? '';
      }

      emit(AiReportSuccess("AI Report submitted successfully!", jobId: jobId));
    } catch (e) {
      emit(AiReportError(e.toString()));
    }
  }

  Map<String, dynamic> _buildBasicInfoPayload() {
    return {
      'course_title': titleController.text,
      'course_code': codeController.text,
      'academic_year': yearController.text,
      'semester': semesterController.text,
      'department': deptController.text,
      'course_type': typeController.text,
      'level': levelController.text,
      'program': programController.text,
      'faculty': facultyController.text,
      'university': uniController.text,
      'coordinator_name': coordinatorController.text,
    };
  }

  Map<String, dynamic> _buildHoursAndStaffPayload() {
    return {
      'credit_hours': creditHoursController.text,
      'num_weeks_actual': numWeeksController.text,
      'total_theoretical_hours': theoreticalHoursController.text,
      'total_practical_hours': practicalHoursController.text,
      'total_field_hours': fieldHoursController.text,
      'total_self_hours': selfHoursController.text,
      'total_other_hours': otherHoursController.text,
      'instructor_fulltime': instructorFulltimeController.text,
      'instructor_parttime': instructorParttimeController.text,
      'ta_fulltime': taFulltimeController.text,
      'ta_parttime': taParttimeController.text,
      'topics_not_covered': topicsNotCoveredController.text,
      'teaching_method_changes': teachingMethodChangesController.text,
    };
  }

  Map<String, dynamic> _buildAssessmentsPayload() {
    return {
      'exam1_eval_date': exam1EvalDateController.text,
      'exam1_date': exam1DateController.text,
      'exam1_marks': exam1MarksController.text,
      'exam1_type': exam1TypeController.text,
      'exam1_clos': exam1ClosController.text,

      'exam2_eval_date': exam2EvalDateController.text,
      'exam2_date': exam2DateController.text,
      'exam2_marks': exam2MarksController.text,
      'exam2_type': exam2TypeController.text,
      'exam2_clos': exam2ClosController.text,

      'midterm_eval_date': midtermEvalDateController.text,
      'midterm_date': midtermDateController.text,
      'midterm_marks': midtermMarksController.text,
      'midterm_type': midtermTypeController.text,
      'midterm_clos': midtermClosController.text,

      'practical_eval_date': practicalEvalDateController.text,
      'practical_date': practicalDateController.text,
      'practical_marks': practicalMarksController.text,
      'practical_type': practicalTypeController.text,
      'practical_clos': practicalClosController.text,

      'oral_eval_date': oralEvalDateController.text,
      'oral_date': oralDateController.text,
      'oral_marks': oralMarksController.text,
      'oral_type': oralTypeController.text,
      'oral_clos': oralClosController.text,

      'written_eval_date': writtenEvalDateController.text,
      'written_date': writtenDateController.text,
      'written_marks': writtenMarksController.text,
      'written_type': writtenTypeController.text,
      'written_clos': writtenClosController.text,

      'assessment_comment': assessmentCommentController.text,
    };
  }

  Map<String, dynamic> _buildExtraDataPayload() {
    return {
      'students_started': studentsStartedController.text,
      'students_completed': studentsCompletedController.text,
      'students_absent': studentsAbsentController.text,
      'students_passed': studentsPassedController.text,
      'pass_percentage': passPercentageController.text,
      'students_failed': studentsFailedController.text,
      'fail_percentage': failPercentageController.text,
      'performance_comment': performanceCommentController.text,
      'performance_notes': performanceNotesController.text,

      'grades': {
        'a_plus_count': aPlusCountController.text,
        'a_plus_pct': aPlusPctController.text,
        'a_count': aCountController.text,
        'a_pct': aPctController.text,
        'b_plus_count': bPlusCountController.text,
        'b_plus_pct': bPlusPctController.text,
        'b_count': bCountController.text,
        'b_pct': bPctController.text,
        'c_plus_count': cPlusCountController.text,
        'c_plus_pct': cPlusPctController.text,
        'c_count': cCountController.text,
        'c_pct': cPctController.text,
        'd_plus_count': dPlusCountController.text,
        'd_plus_pct': dPlusPctController.text,
        'd_count': dCountController.text,
        'd_pct': dPctController.text,
      },

      'survey_means': surveyMeansController.text,
      'survey_timing': surveyTimingController.text,
      'survey_participants': surveyParticipantsController.text,
      'survey_pct': surveyPctController.text,
      'satisfaction_1': satisfaction1Controller.text,
      'satisfaction_2': satisfaction2Controller.text,
      'satisfaction_3': satisfaction3Controller.text,
      'dissatisfaction_1': dissatisfaction1Controller.text,
      'dissatisfaction_2': dissatisfaction2Controller.text,
      'dissatisfaction_3': dissatisfaction3Controller.text,

      'instructor_reflection': instructorReflectionController.text,
      'uncompleted_actions': uncompletedActionsController.text,
      'approval_date': approvalDateController.text,
      'approval_attachment': approvalAttachmentController.text,
    };
  }

  Map<String, dynamic> _buildDynamicListsPayload() {
    return {
      'instructors': instructorsList
          .map(
            (e) => {
              'name': e.nameController.text,
              'department': e.deptController.text,
              'degree': e.degreeController.text,
              'specialty': e.specialtyController.text,
            },
          )
          .toList(),

      'improvement_plan': improvementPlanList
          .map(
            (e) => {
              'no': e.noController.text,
              'point': e.pointController.text,
              'action': e.actionController.text,
              'method': e.methodController.text,
              'notes': e.notesController.text,
            },
          )
          .toList(),
    };
  }

  // ===========================================================================
  // 5. DISPOSAL LOGIC
  // ===========================================================================
  @override
  Future<void> close() {
    disposeAllControllers();

    for (var instructor in instructorsList) {
      instructor.dispose();
    }

    for (var plan in improvementPlanList) {
      plan.dispose();
    }

    return super.close();
  }
}
