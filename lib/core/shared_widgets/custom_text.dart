import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String title;

  final TextStyle textStyle;

  final TextAlign? textAlign;

  final int? maxLines;
  final TextOverflow? overflow;

  const CustomText({
    super.key,
    required this.title,
    required this.textStyle,
    this.textAlign,
    this.maxLines,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: textStyle,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}
