import 'package:flutter/material.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';

// Defines a model for configuring text fields.
class TextFieldModel {
  // Placeholder text for the text field.
  final String? hintText;

  // Label text for the text field.
  final CustomText customTextLabel;

  final bool? isObscured;

  // Controller for managing the text field's content.
  final TextEditingController controller;

  // Type of keyboard to display.
  final TextInputType keyboardType;

  // Manages the focus state of the text field.
  final FocusNode? focusNode;

  // Callback for when the text field is tapped.
  final void Function()? onTap;

  // Callback for when the text field is submitted.
  final void Function(String)? onFieldSubmitted;

  // Validator function for the text field.
  final String? Function(String?)? validator;

  // Constructor for TextFieldModel.
  // All parameters except onTap, focusNode, and onFieldSubmitted are required.
  const TextFieldModel({
    this.hintText,
    required this.controller,
    required this.keyboardType,
    required this.validator,
    required this.customTextLabel,
    this.onTap,
    this.focusNode,
    this.onFieldSubmitted,
    this.isObscured,
  });
}
