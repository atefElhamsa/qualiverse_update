import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class FolderGridItem extends StatefulWidget {
  final EvidenceFolderModel folder;
  final double itemWidth;
  final bool isStatistics;
  final bool isGeneral;
  final int? departmentId;
  final int yearId, termId, levelId, courseId;

  const FolderGridItem({
    super.key,
    required this.folder,
    required this.itemWidth,
    required this.isStatistics,
    required this.isGeneral,
    this.departmentId,
    required this.yearId,
    required this.termId,
    required this.levelId,
    required this.courseId,
  });

  @override
  State<FolderGridItem> createState() => _FolderGridItemState();
}

class _FolderGridItemState extends State<FolderGridItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final folderName = widget.folder.name.tr();
    return SizedBox(
      width: widget.itemWidth,
      child: Tooltip(
        message: folderName,
        child: GestureDetector(
          onTap: () => _showFilesDialog(context),
          child: MouseRegion(
            onEnter: (_) => setState(() => _isHovered = true),
            onExit: (_) => setState(() => _isHovered = false),
            cursor: SystemMouseCursors.click,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
              constraints: BoxConstraints(minHeight: 56.h),
              decoration: BoxDecoration(
                color: _isHovered ? const Color(0xFFF1F5F9) : AppColors.grey,
                borderRadius: BorderRadius.circular(25.r),
                boxShadow: _isHovered
                    ? [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ]
                    : [],
              ),
              child: Row(
                children: [
                  _buildIcon(),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Text(
                      folderName,
                      style: GoogleFonts.almarai(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: _isHovered
                            ? const Color(0xFF0F569E)
                            : AppColors.mainBlack,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIcon() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: 38.w,
      height: 38.h,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: _isHovered
              ? [const Color(0xFF0F569E), const Color(0xFF4285F4)]
              : [
                  AppColors.itemContainerColorEdit1,
                  AppColors.itemContainerColorEdit2,
                ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: _isHovered
            ? [
                BoxShadow(
                  color: const Color(0xFF4285F4).withOpacity(0.3),
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ]
            : [],
      ),
      child: Center(
        child: Icon(
          Icons.folder_shared_rounded,
          color: AppColors.white,
          size: 24.sp,
        ),
      ),
    );
  }

  void _showFilesDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => EvidenceFolderFilesCubit()),
          BlocProvider(create: (_) => GetFileDataCubit()),
        ],
        child: Dialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.r),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30.r),
            child: SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.85,
              child: widget.isStatistics
                  ? EvidenceFileStatisticsScreen(
                      departmentId: widget.departmentId,
                      academicYearId: widget.yearId,
                      termId: widget.termId,
                      levelId: widget.levelId,
                      courseId: widget.courseId,
                    )
                  : widget.isGeneral
                  ? EvidenceFileGeneralScreen(
                      folderId: widget.folder.id,
                      folderName: widget.folder.name,
                      departmentId: widget.departmentId,
                      academicYearId: widget.yearId,
                      termId: widget.termId,
                      levelId: widget.levelId,
                      courseId: widget.courseId,
                    )
                  : EvidenceFolderFilesScreen(
                      folderName: widget.folder.name,
                      folderId: widget.folder.id,
                      departmentId: widget.departmentId,
                      academicYearId: widget.yearId,
                      termId: widget.termId,
                      levelId: widget.levelId,
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
