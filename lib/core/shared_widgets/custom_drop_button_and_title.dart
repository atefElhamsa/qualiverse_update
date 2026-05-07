import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';

/// A widget that displays a title and a custom dropdown button.
class CustomDropButtonAndTitle extends StatelessWidget {
  /// Creates a [CustomDropButtonAndTitle] widget.
  const CustomDropButtonAndTitle({
    super.key,
    required this.dropButtonModel,
    required this.title,
  });

  /// The model for the custom dropdown button.
  final DropButtonModel dropButtonModel;

  /// The title to be displayed above the dropdown button.
  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 592.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 8.w, bottom: 4.h),
            child: CustomText(
              title: title,
              textStyle: GoogleFonts.almarai(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: Theme.of(context).scaffoldBackgroundColor == AppColors.white
                    ? AppColors.mainBlack
                    : AppColors.white,
              ),
            ),
          ),
          CustomDropButton(dropButtonModel: dropButtonModel),
        ],
      ),
    );
  }
}
