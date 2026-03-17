import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class EditFilesList extends StatelessWidget {
  const EditFilesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Expanded(child: FirstContainer()),
        SizedBox(width: 35.w),
        Image.asset(AppImages.editFileImage),
      ],
    );
  }
}
