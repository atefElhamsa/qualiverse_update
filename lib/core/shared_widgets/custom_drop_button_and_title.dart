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
      child: ListTile(
        title: Padding(
          padding: const EdgeInsets.only(bottom: 3),
          child: CustomText(
            title: title,
            textStyle: GoogleFonts.inter(
              fontSize: 20.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.mainBlack,
            ),
          ),
        ),
        subtitle: CustomDropButton(dropButtonModel: dropButtonModel),
      ),
    );
  }
}
