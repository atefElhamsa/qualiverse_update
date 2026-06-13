import 'package:flutter/material.dart';

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
