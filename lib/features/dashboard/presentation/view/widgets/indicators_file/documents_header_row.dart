import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class DocumentsHeaderRow extends StatelessWidget {
  const DocumentsHeaderRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor == AppColors.white
            ? AppColors.grey
            : AppColors.mainBlack,
        borderRadius: BorderRadius.circular(12.r),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 22),
      child: Row(
        children: List.generate(
          kHeaders.length,
          (i) => Expanded(
            flex: kFlex[i],
            child: Text(
              kHeaders[i],
              textAlign: TextAlign.center,
              softWrap: true,
              overflow: TextOverflow.visible,
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w800,
                fontSize: 14.sp,
                color: Theme.of(context).colorScheme.onSecondary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
