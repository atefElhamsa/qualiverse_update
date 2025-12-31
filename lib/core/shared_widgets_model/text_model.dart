import 'package:flutter/material.dart';

// Represents a model for text styling.
class TextModel {
  // The text content.
  final String title;

  // The font size.
  final int sizeNumber;

  // The font weight.
  final FontWeight fontWeight;

  // The text color.
  final Color textColor;

  // Constructs a TextModel.
  TextModel({
    required this.title,
    required this.sizeNumber,
    required this.fontWeight,
    required this.textColor,
  });
}
