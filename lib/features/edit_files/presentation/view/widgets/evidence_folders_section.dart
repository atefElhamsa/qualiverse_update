import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class EvidenceFoldersSection extends StatelessWidget {
  final int? departmentId;
  final int yearId;
  final int termId;
  final int levelId;
  final int courseId;

  const EvidenceFoldersSection({
    super.key,
    this.departmentId,
    required this.yearId,
    required this.termId,
    required this.levelId,
    required this.courseId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EvidenceFolderCubit, EvidenceFolderState>(
      builder: (context, state) {
        if (state is EvidenceFolderSuccess) {
          final List<EvidenceFolderModel> allApiFolders = state.evidenceFolders;
          
          // FIND REAL FOLDERS BY NAME
          final statsFolder = _findFolder(allApiFolders, ['Statistics', 'إحصائيات', 'الإحصائيات', 'إحصائية']);
          final surveyFolder = _findFolder(allApiFolders, ['Survey', 'Surveys', 'استبيان', 'استبيانات', 'الاستبيانات']);
          final docAnalysisFolder = _findFolder(allApiFolders, ['Documentary Analysis', 'التحليل الوثائقي', 'تحليل وثائقي']);

          final List<EvidenceFolderModel> orderedFolders = [];
          if (statsFolder != null) orderedFolders.add(statsFolder);
          if (surveyFolder != null) orderedFolders.add(surveyFolder);
          if (docAnalysisFolder != null) orderedFolders.add(docAnalysisFolder);

          // ADD REST OF FOLDERS
          orderedFolders.addAll(allApiFolders.where((f) => 
            f.id != statsFolder?.id && 
            f.id != surveyFolder?.id && 
            f.id != docAnalysisFolder?.id
          ));

          if (orderedFolders.isEmpty) return const SizedBox.shrink();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ContainerWidget(
                widget: LayoutBuilder(
                  builder: (context, constraints) {
                    final itemWidth = (constraints.maxWidth - 10.w) / 2;
                    return Wrap(
                      spacing: 10.w,
                      runSpacing: 10.h,
                      children: orderedFolders.map((folder) {
                        return _FolderGridItem(
                          folder: folder,
                          itemWidth: itemWidth,
                          isStatistics: folder.id == statsFolder?.id,
                          isGeneral: (folder.id == surveyFolder?.id || folder.id == docAnalysisFolder?.id),
                          departmentId: departmentId,
                          yearId: yearId,
                          termId: termId,
                          levelId: levelId,
                          courseId: courseId,
                        );
                      }).toList(),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  EvidenceFolderModel? _findFolder(List<EvidenceFolderModel> list, List<String> names) {
    try {
      return list.firstWhere((f) => names.contains(f.name.trim()));
    } catch (_) {
      return null;
    }
  }
}

class _FolderGridItem extends StatefulWidget {
  final EvidenceFolderModel folder;
  final double itemWidth;
  final bool isStatistics;
  final bool isGeneral;
  final int? departmentId;
  final int yearId;
  final int termId;
  final int levelId;
  final int courseId;

  const _FolderGridItem({
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
  State<_FolderGridItem> createState() => _FolderGridItemState();
}

class _FolderGridItemState extends State<_FolderGridItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final folderName = widget.folder.name.tr();
    return SizedBox(
      width: widget.itemWidth,
      child: Tooltip(
        message: folderName,
        child: GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (_) => MultiBlocProvider(
                providers: [
                  BlocProvider(create: (_) => EvidenceFolderFilesCubit()),
                  BlocProvider(create: (_) => GetFileDataCubit()),
                ],
                child: Dialog(
                  insetPadding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 30.h,
                  ),
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
          },
          child: MouseRegion(
            onEnter: (_) => setState(() => _isHovered = true),
            onExit: (_) => setState(() => _isHovered = false),
            cursor: SystemMouseCursors.click,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: EdgeInsets.symmetric(
                horizontal: 14.w,
                vertical: 12.h,
              ),
              constraints: BoxConstraints(minHeight: 56.h),
              decoration: BoxDecoration(
                color: _isHovered ? const Color(0xFFF1F5F9) : AppColors.grey,
                borderRadius: BorderRadius.circular(25.r),
                boxShadow: _isHovered 
                  ? [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))]
                  : [],
              ),
              child: Row(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 38.w,
                    height: 38.h,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: _isHovered 
                          ? [const Color(0xFF0F569E), const Color(0xFF4285F4)]
                          : [AppColors.itemContainerColorEdit1, AppColors.itemContainerColorEdit2],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(8.r),
                      boxShadow: _isHovered
                        ? [BoxShadow(color: const Color(0xFF4285F4).withOpacity(0.3), blurRadius: 5, offset: const Offset(0, 2))]
                        : [],
                    ),
                    child: Center(
                      child: Icon(
                        Icons.folder_shared_rounded,
                        color: AppColors.white,
                        size: 24.sp,
                      ),
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Text(
                      folderName,
                      style: GoogleFonts.almarai(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: _isHovered ? const Color(0xFF0F569E) : AppColors.mainBlack,
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
}
