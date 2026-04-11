import 'package:flutter/material.dart';
import 'package:qualiverse/core/shared_widgets/custom_text.dart';

class AddUserButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const AddUserButton({super.key, this.onPressed});

  static const accentColor = Color(0xFF2d6bcf);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: accentColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(horizontal: 20),
        ),
        child: const CustomText(
          title: 'Add User',
          textStyle: TextStyle(color: Colors.white, fontSize: 13),
        ),
      ),
    );
  }
}
