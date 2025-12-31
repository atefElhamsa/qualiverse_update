import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:open_filex/open_filex.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';

class AiReportFoundFile extends StatelessWidget {
  const AiReportFoundFile({super.key, this.file});

  // uploaded file
  final File? file;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 201.h,
      width: 380.w,
      child: Center(
        child: TextButton(
          onPressed: () async {
            if (file != null) {
              await OpenFilex.open(file!.path); // open file
            }
          },
          // file name
          child: CustomText(
            title: file!.path.split('\\').last,
            textStyle: Theme.of(
              context,
            ).textTheme.headlineLarge!.copyWith(color: AppColors.green),
          ),
        ),
      ),
    );
  }
}
