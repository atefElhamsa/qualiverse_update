import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class AiDescriptionSubmitButton extends StatelessWidget {
  final AiDescriptionCubit cubit;

  const AiDescriptionSubmitButton({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AiDescriptionCubit, AiDescriptionState>(
      builder: (context, state) {
        final bool isUnsaved = cubit.hasUnsavedCustomFiles;
        final bool hasCustom =
            cubit.customDocxFile != null || cubit.customPdfFile != null;

        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (hasCustom) ...[
              OutlinedButton.icon(
                onPressed: () => cubit.revertToAiFiles(),
                icon: const Icon(
                  Icons.settings_backup_restore_rounded,
                  color: AppColors.aiPrimary,
                ),
                label: Text(
                  "returnedToAiFiles".tr(),
                  style: GoogleFonts.almarai(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.aiPrimary,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    horizontal: 35.w,
                    vertical: 16.h,
                  ),
                  side: const BorderSide(
                    color: AppColors.aiPrimary,
                    width: 1.5,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
              ),
              SizedBox(width: 15.w),
            ],
            ElevatedButton(
              onPressed: () async {
                if (isUnsaved) {
                  await cubit.uploadCustomFile(
                    docx: cubit.customDocxFile!,
                    pdf: cubit.customPdfFile!,
                  );
                  // If upload is successful, hasUnsavedCustomFiles will become false
                  if (!cubit.hasUnsavedCustomFiles) {
                    cubit.confirmFinal();
                  }
                } else {
                  cubit.confirmFinal();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.aiPrimary,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 16.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                elevation: 4,
              ),
              child: Text(
                "submit".tr(),
                style: GoogleFonts.almarai(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
