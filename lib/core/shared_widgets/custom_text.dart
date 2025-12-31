import 'package:flutter/material.dart';

// Define a custom text widget that extends StatelessWidget.
class CustomText extends StatelessWidget {
  // Declare a final string variable to hold the text title.
  final String title;

  // Declare a final TextStyle variable to hold the text style.
  final TextStyle textStyle;

  // Declare a final TextAlign variable to control the alignment of the text.
  final TextAlign? textAlign;

  // Constructor for the CustomText widget.
  const CustomText({
    super.key,
    required this.title,
    required this.textStyle,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    // Return a Text widget with the given title, style, and center alignment.
    return Text(title, style: textStyle, textAlign: textAlign);
  }
}
