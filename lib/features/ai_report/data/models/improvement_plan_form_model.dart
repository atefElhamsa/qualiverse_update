import 'package:flutter/material.dart';

class ImprovementPlanFormModel {
  final TextEditingController noController = TextEditingController();
  final TextEditingController pointController = TextEditingController();
  final TextEditingController actionController = TextEditingController();
  final TextEditingController methodController = TextEditingController();
  final TextEditingController notesController = TextEditingController();

  void dispose() {
    noController.dispose();
    pointController.dispose();
    actionController.dispose();
    methodController.dispose();
    notesController.dispose();
  }
}
