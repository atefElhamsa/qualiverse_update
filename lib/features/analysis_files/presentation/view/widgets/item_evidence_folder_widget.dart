import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qualiverse/features/analysis_files/presentation/controller/evidence_folder_files_cubit.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class ItemEvidenceFolderWidget extends StatefulWidget {
  const ItemEvidenceFolderWidget({
    super.key,
    required this.itemFolderModel,
    required this.evidenceFolderModel,
  });

  final ItemFolderModel itemFolderModel;
  final EvidenceFolderModel evidenceFolderModel;

  @override
  State<ItemEvidenceFolderWidget> createState() =>
      _ItemEvidenceFolderWidgetState();
}

class _ItemEvidenceFolderWidgetState extends State<ItemEvidenceFolderWidget> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (_) => BlocProvider(
              create: (_) => EvidenceFolderFilesCubit()
                ..getEvidenceFiles(
                  folderId: widget.evidenceFolderModel.id,
                ),
              child: Dialog(
                insetPadding: EdgeInsets.symmetric(
                  horizontal: 40.w,
                  vertical: 30.h,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: EvidenceFolderFilesScreen(
                    folderName: widget.evidenceFolderModel.name,
                    folderId: widget.evidenceFolderModel.id,
                  ),
                ),
              ),
            ),
          );
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
          decoration: BoxDecoration(
            color: _hovered
                ? AppColors.progressColor.withOpacity(0.05)
                : (isDark ? const Color(0xFF1A1F2E) : Colors.white),
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: _hovered
                  ? AppColors.progressColor.withOpacity(0.5)
                  : AppColors.greyLight.withOpacity(0.2),
              width: 1.5,
            ),
            boxShadow: _hovered
                ? [
                    BoxShadow(
                      color: AppColors.progressColor.withOpacity(0.1),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ]
                : [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
          ),
          child: Row(
            children: [
              // Icon container
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 56.w,
                height: 56.h,
                decoration: BoxDecoration(
                  color: _hovered
                      ? AppColors.progressColor.withOpacity(0.12)
                      : AppColors.progressColor.withOpacity(0.07),
                  borderRadius: BorderRadius.circular(14.r),
                ),
                child: Padding(
                  padding: EdgeInsets.all(12.r),
                  child: Image.asset(
                    widget.itemFolderModel.image,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              SizedBox(width: 18.w),

              // Text info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.evidenceFolderModel.name,
                      style: GoogleFonts.cairo(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      widget.evidenceFolderModel.description,
                      style: GoogleFonts.cairo(
                        fontSize: 13.sp,
                        color: AppColors.greyLight,
                        fontWeight: FontWeight.w400,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              SizedBox(width: 12.w),

              // Arrow
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 36.w,
                height: 36.h,
                decoration: BoxDecoration(
                  color: _hovered
                      ? AppColors.progressColor.withOpacity(0.12)
                      : AppColors.greyLight.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: _hovered
                      ? AppColors.progressColor
                      : AppColors.greyLight,
                  size: 16.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
