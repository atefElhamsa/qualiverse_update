// Defines a model for a dropdown button.
import 'package:flutter/foundation.dart';

class DropButtonModel {
  // The currently selected data in the dropdown.
  dynamic selectedData;

  // A list of data to be displayed in the dropdown.
  final List listOfData;

  // The hint text to be displayed when no item is selected.
  final String hintText;

  final double? hintSize;

  final ValueChanged<dynamic>? onChanged;

  // Constructor for the DropButtonModel.
  DropButtonModel({
    required this.selectedData,
    required this.listOfData,
    required this.hintText,
    this.hintSize,
    this.onChanged,
  });
}
