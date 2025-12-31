import 'package:flutter/material.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';

class HoverButton extends StatefulWidget {
  const HoverButton({
    super.key,
    required this.buttonTitle,
    required this.mainColor,
    this.onPressed,
  });

  final String buttonTitle;
  final Color mainColor;
  final void Function()? onPressed;

  @override
  State<HoverButton> createState() => _HoverButtonState();
}

class _HoverButtonState extends State<HoverButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 72,
      child: ElevatedButton(
        onPressed: widget.onPressed,
        onHover: (isHovered) {
          setState(() {
            _isHovered = isHovered;
          });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: _isHovered
              ? Theme.of(context).scaffoldBackgroundColor == AppColors.white
                    ? AppColors.black
                    : AppColors.white
              : widget.mainColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
        ),
        child: Text(
          widget.buttonTitle,
          style: TextStyle(
            color: Theme.of(context).scaffoldBackgroundColor == AppColors.white
                ? AppColors.white
                : AppColors.black,
            fontSize: 24,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}
