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

  // A list of items that should be disabled in the dropdown.
  final List? disabledItems;

  // Whether to show the clear button when a value is selected.
  final bool showClearButton;

  // Constructor for the DropButtonModel.
  DropButtonModel({
    required this.selectedData,
    required this.listOfData,
    required this.hintText,
    this.hintSize,
    this.onChanged,
    this.disabledItems,
    this.showClearButton = false,
  });
}
