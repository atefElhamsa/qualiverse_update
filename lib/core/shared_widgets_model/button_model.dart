import 'package:flutter/material.dart';
import 'package:qualiverse/core/shared_widgets/custom_text.dart';

// Represents the data model for a button widget.
class ButtonModel {
  // Callback function to be executed when the button is pressed.
  final void Function()? onPressed;

  // Background color of the button.
  final Color backgroundColor;

  // Radius of the button's corners.
  final double radius;

  // Custom text widget to be displayed on the button.
  final CustomText customText;

  // Space between the button and the text.
  final double? space;

  // Constructor for ButtonModel.
  ButtonModel({
    required this.onPressed,
    required this.backgroundColor,
    required this.radius,
    required this.customText,
    this.space = 0,
  });
}
