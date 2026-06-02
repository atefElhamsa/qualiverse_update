import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'ai_report_state.dart';

class InstructorFormModel {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController deptController = TextEditingController();
  final TextEditingController degreeController = TextEditingController();
  final TextEditingController specialtyController = TextEditingController();

  void dispose() {
    nameController.dispose();
    deptController.dispose();
    degreeController.dispose();
    specialtyController.dispose();
  }
}

class AiReportCubit extends Cubit<AiReportState> {
  AiReportCubit() : super(AiReportInitial());

  int currentPage = 0;

  // Basic Info Controllers
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

  // Credit Hours Controllers
  final TextEditingController creditHoursController = TextEditingController();
  final TextEditingController numWeeksController = TextEditingController();
  final TextEditingController theoreticalHoursController =
      TextEditingController();
  final TextEditingController practicalHoursController =
      TextEditingController();
  final TextEditingController fieldHoursController = TextEditingController();
  final TextEditingController selfHoursController = TextEditingController();
  final TextEditingController otherHoursController = TextEditingController();

  // Staff numbers
  final TextEditingController instructorFulltimeController =
      TextEditingController(text: "0");
  final TextEditingController instructorParttimeController =
      TextEditingController(text: "1");
  final TextEditingController taFulltimeController = TextEditingController(
    text: "0",
  );
  final TextEditingController taParttimeController = TextEditingController(
    text: "1",
  );

  // Topics & Changes
  final TextEditingController topicsNotCoveredController =
      TextEditingController();
  final TextEditingController teachingMethodChangesController =
      TextEditingController();

  // Assessment Methods / Exam 1
  final TextEditingController exam1EvalDateController = TextEditingController();
  final TextEditingController exam1DateController = TextEditingController();
  final TextEditingController exam1MarksController = TextEditingController();
  final TextEditingController exam1TypeController = TextEditingController();
  final TextEditingController exam1ClosController = TextEditingController();

  // Exam 2
  final TextEditingController exam2EvalDateController = TextEditingController();
  final TextEditingController exam2DateController = TextEditingController();
  final TextEditingController exam2MarksController = TextEditingController();
  final TextEditingController exam2TypeController = TextEditingController();
  final TextEditingController exam2ClosController = TextEditingController();

  // Midterm
  final TextEditingController midtermEvalDateController =
      TextEditingController();
  final TextEditingController midtermDateController = TextEditingController();
  final TextEditingController midtermMarksController = TextEditingController();
  final TextEditingController midtermTypeController = TextEditingController();
  final TextEditingController midtermClosController = TextEditingController();

  // Practical
  final TextEditingController practicalEvalDateController =
      TextEditingController();
  final TextEditingController practicalDateController = TextEditingController();
  final TextEditingController practicalMarksController =
      TextEditingController();
  final TextEditingController practicalTypeController = TextEditingController();
  final TextEditingController practicalClosController = TextEditingController();

  // Oral
  final TextEditingController oralEvalDateController = TextEditingController();
  final TextEditingController oralDateController = TextEditingController();
  final TextEditingController oralMarksController = TextEditingController();
  final TextEditingController oralTypeController = TextEditingController();
  final TextEditingController oralClosController = TextEditingController();

  // Written
  final TextEditingController writtenEvalDateController =
      TextEditingController();
  final TextEditingController writtenDateController = TextEditingController();
  final TextEditingController writtenMarksController = TextEditingController();
  final TextEditingController writtenTypeController = TextEditingController();
  final TextEditingController writtenClosController = TextEditingController();

  // Assessment Comment
  final TextEditingController assessmentCommentController =
      TextEditingController();

  // Dynamic Instructors List
  final List<InstructorFormModel> instructorsList = [InstructorFormModel()];

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

  void submitReport() {
    emit(AiReportLoading());
    // Simulate successful API submission
    Future.delayed(const Duration(seconds: 1), () {
      emit(AiReportSuccess("AI Report submitted successfully!"));
    });
  }

  @override
  Future<void> close() {
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

    for (var instructor in instructorsList) {
      instructor.dispose();
    }

    return super.close();
  }
}
