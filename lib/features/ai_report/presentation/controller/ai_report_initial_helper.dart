import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'ai_report_cubit.dart';

extension AiReportInitialHelper on AiReportCubit {
  void initializeLocalizedValues([BuildContext? context]) {
    // Dynamic initial values for Academic Year
    if (yearController.text.isEmpty) {
      yearController.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
    }
    // Dynamic initial values for Faculty
    if (facultyController.text.isEmpty ||
        facultyController.text == "Faculty of Computers and Information") {
      facultyController.text = "Faculty of Computers and Information";
    }

    // Dynamic initial values for University
    if (uniController.text.isEmpty ||
        uniController.text == "Tanta University") {
      uniController.text = "Tanta University";
    }

    // Dynamic initial values for Course Type
    final type = typeController.text;
    if (type.isEmpty || type == "Theoretical") {
      typeController.text = "Theoretical";
    } else if (type == "Practical") {
      typeController.text = "Practical";
    }

    // Dynamic initial values for Level
    final level = levelController.text;
    if (level.isEmpty || level == "Level 1") {
      levelController.text = "Level 1";
    } else if (level == "Level 2") {
      levelController.text = "Level 2";
    } else if (level == "Level 3") {
      levelController.text = "Level 3";
    } else if (level == "Level 4") {
      levelController.text = "Level 4";
    }

    // Dynamic initial values for Department
    final dept = deptController.text;
    if (dept.isEmpty || dept == "Computer Science") {
      deptController.text = "Computer Science";
    } else if (dept == "Information Technology") {
      deptController.text = "Information Technology";
    } else if (dept == "Software Engineering") {
      deptController.text = "Software Engineering";
    } else if (dept == "Information System") {
      deptController.text = "Information System";
    } else if (dept == "Data Analysis and Artificial Intelligence") {
      deptController.text = "Data Analysis and Artificial Intelligence";
    }

    // Dynamic initial values for Semester
    final sem = semesterController.text;
    if (sem.isEmpty || sem == "First Term") {
      semesterController.text = "First Term";
    } else if (sem == "Second Term") {
      semesterController.text = "Second Term";
    }
  }
}
