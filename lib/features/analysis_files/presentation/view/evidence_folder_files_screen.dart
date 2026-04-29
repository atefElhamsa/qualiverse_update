import 'package:dio/dio.dart' as dio;
import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';
import 'package:qualiverse/features/analysis_files/presentation/controller/evidence_folder_files_state.dart';
import 'package:qualiverse/features/analysis_files/presentation/view/widgets/evidence_folder_files/evidence_folder_file_item.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';
import 'package:qualiverse/features/analysis_files/presentation/view/widgets/evidence_folder_files/evidence_statistics_view.dart';
import 'package:qualiverse/features/edit_files/presentation/view/widgets/folder_files/folder_files_parts.dart';
import '../controller/evidence_folder_files_cubit.dart';

class EvidenceFolderFilesScreen extends StatefulWidget {
  final String folderName;
  final int folderId;
  final bool isStatistics;

  const EvidenceFolderFilesScreen({
    super.key,
    required this.folderName,
    required this.folderId,
    this.isStatistics = false,
  });

  @override
  State<EvidenceFolderFilesScreen> createState() =>
      _EvidenceFolderFilesScreenState();
}

class _EvidenceFolderFilesScreenState extends State<EvidenceFolderFilesScreen> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final cubit = EvidenceFolderFilesCubit.get(context);
      if (widget.isStatistics) {
        cubit.getStatistics(
          evidenceFolderId: widget.folderId,
          academicYearId: 1,
          semesterId: 1,
          levelId: 1,
          courseId: 1,
        );
      } else {
        cubit.getEvidenceFiles(folderId: widget.folderId);
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _pickAndUpload() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (result == null || result.files.isEmpty) return;

    final multipartFiles = await Future.wait(
      result.files
          .where((f) => f.path != null)
          .map((f) => dio.MultipartFile.fromFile(f.path!, filename: f.name)),
    );

    if (!mounted) return;
    await EvidenceFolderFilesCubit.get(context).uploadFiles(
      folderId: widget.folderId,
      files: multipartFiles,
      academicYearId: 1,
      semesterId: 1,
      levelId: 1,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: BlocConsumer<EvidenceFolderFilesCubit, EvidenceFolderFilesState>(
        listener: (context, state) {
          if (state is UploadEvidenceFilesSuccess) {
            showSnackBar(context, state.message, AppColors.green);
          }
          if (state is UploadEvidenceFilesFailure) {
            showSnackBar(context, state.error, AppColors.red);
          }
          if (state is DeleteEvidenceFileSuccess) {
            showSnackBar(context, state.message, AppColors.green);
          }
          if (state is DeleteEvidenceFileFailure) {
            showSnackBar(context, state.error, AppColors.red);
          }
        },
        builder: (context, state) {
          final cubit = EvidenceFolderFilesCubit.get(context);

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FolderFilesHeader(
                folderName: widget.folderName,
                fileCount: widget.isStatistics ? null : cubit.allFiles.length,
              ),
              Expanded(child: _buildBody(context, state, cubit)),
            ],
          );
        },
      ),
    );
  }

  Widget _buildBody(
    BuildContext context,
    EvidenceFolderFilesState state,
    EvidenceFolderFilesCubit cubit,
  ) {
    if (widget.isStatistics) {
      return _buildStatisticsBody(context, state, cubit);
    } else {
      return _buildFilesBody(context, state, cubit);
    }
  }

  Widget _buildFilesBody(
    BuildContext context,
    EvidenceFolderFilesState state,
    EvidenceFolderFilesCubit cubit,
  ) {
    if (state is EvidenceFolderFilesLoading && cubit.allFiles.isEmpty) {
      return const CustomLoading();
    }

    if (state is EvidenceFolderFilesFailure && cubit.allFiles.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(40.w),
          child: RetryWidget(
            title: state.error,
            onPressed: () => cubit.getEvidenceFiles(folderId: widget.folderId),
          ),
        ),
      );
    }

    return Column(
      children: [
        // Upload Button and Search Bar Toolbar
        FolderFilesToolbar(
          onUpload: _pickAndUpload,
          isUploading: state is UploadEvidenceFilesLoading,
          searchController: _searchController,
        ),
        
        SizedBox(height: 16.h),

        Expanded(
          child: ValueListenableBuilder(
            valueListenable: _searchController,
            builder: (context, value, child) {
              final query = value.text.toLowerCase().trim();
              final filteredFiles = query.isEmpty
                  ? cubit.allFiles
                  : cubit.allFiles
                      .where((f) => f.fileName.toLowerCase().contains(query))
                      .toList();

              if (filteredFiles.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.folder_open_rounded,
                        size: 64.sp,
                        color: AppColors.greyLight.withOpacity(0.5),
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        "noIndicatorsFound".tr(),
                        style: GoogleFonts.cairo(
                          fontSize: 16.sp,
                          color: AppColors.greyLight,
                        ),
                      ),
                    ],
                  ),
                );
              }

              return ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                itemCount: filteredFiles.length,
                separatorBuilder: (_, __) => SizedBox(height: 12.h),
                itemBuilder: (context, index) {
                  return EvidenceFolderFileItem(
                    file: filteredFiles[index],
                    isArabic: context.locale.languageCode == 'ar',
                    folderId: widget.folderId,
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildStatisticsBody(
    BuildContext context,
    EvidenceFolderFilesState state,
    EvidenceFolderFilesCubit cubit,
  ) {
    // Show loading while we don't have statistics and no error has occurred
    if (cubit.statistics == null && state is! GetEvidenceStatisticsFailure) {
      return const CustomLoading();
    }

    // Show premium error UI if statistics failed and we have no cached data
    if (state is GetEvidenceStatisticsFailure && (cubit.statistics == null || cubit.statistics!.isEmpty)) {
      return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(20.r),
                decoration: BoxDecoration(
                  color: AppColors.red.withOpacity(0.05),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.info_outline_rounded,
                  size: 60.sp,
                  color: AppColors.red.withOpacity(0.4),
                ),
              ),
              SizedBox(height: 24.h),
              Text(
                state.error,
                textAlign: TextAlign.center,
                style: GoogleFonts.cairo(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.mainBlack.withOpacity(0.6),
                ),
              ),
              SizedBox(height: 32.h),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () => cubit.getStatistics(
                    evidenceFolderId: widget.folderId,
                    academicYearId: 1,
                    semesterId: 1,
                    levelId: 1,
                    courseId: 1,
                  ),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 12.h),
                    decoration: BoxDecoration(
                      color: AppColors.progressColor,
                      borderRadius: BorderRadius.circular(30.r),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.progressColor.withOpacity(0.3),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.refresh_rounded, color: Colors.white, size: 18.sp),
                        SizedBox(width: 8.w),
                        Text(
                          'retry'.tr(),
                          style: GoogleFonts.cairo(
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    // Show statistics if available
    if (cubit.statistics != null && cubit.statistics!.isNotEmpty) {
      return ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: cubit.statistics!.length,
        itemBuilder: (context, index) {
          return EvidenceStatisticsView(statistics: cubit.statistics![index]);
        },
      );
    }

    // Only show "No data" if the list is explicitly empty after success
    return Center(
      child: Text(
        "noStatisticsYet".tr(),
        style: GoogleFonts.cairo(
          fontSize: 16.sp,
          color: AppColors.greyLight,
        ),
      ),
    );
  }
}
