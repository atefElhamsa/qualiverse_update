import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/features/all_features_imports/all_features_imports.dart';

class EditFilesList extends StatelessWidget {
  const EditFilesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FirstContainer(),
        SizedBox(height: 17.h),
        SecondContainer(),
        SizedBox(height: 17.h),
        ThirdContainer(),
        SizedBox(height: 17.h),
      ],
    );
  }
}
