import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/core/shared_widgets_model/button_model.dart';

import 'custom_text.dart';

// A custom button widget that can be configured with a ButtonModel.
class CustomButton extends StatelessWidget {
  // Constructor for CustomButton, requires a ButtonModel.
  const CustomButton({super.key, required this.buttonModel});

  // The model that defines the button's appearance and behavior.
  final ButtonModel buttonModel;

  // Builds the UI for the custom button.
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: buttonModel.onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonModel.backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(buttonModel.radius.r),
        ),
      ),
      label: Padding(
        padding: EdgeInsets.all(buttonModel.space!),
        child: CustomText(
          title: buttonModel.customText.title,
          textStyle: buttonModel.customText.textStyle,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
