import 'dart:ui';
import 'package:dio/dio.dart' as dio;
import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qualiverse/features/edit_files/presentation/controller/evidence_folder_files_state.dart';
import 'package:qualiverse/features/edit_files/presentation/view/widgets/evidence_folder_files/evidence_folder_file_item.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';
import '../controller/evidence_folder_files_cubit.dart';

class EvidenceFileStatisticsScreen extends StatefulWidget {
  final int academicYearId;
  final int termId;
  final int levelId;
  final int? departmentId;

  const EvidenceFileStatisticsScreen({
    super.key,
    required this.academicYearId,
    required this.termId,
    required this.levelId,
    this.departmentId,
  });

  @override
  State<EvidenceFileStatisticsScreen> createState() =>
      _EvidenceFileStatisticsScreenState();
}

class _EvidenceFileStatisticsScreenState
    extends State<EvidenceFileStatisticsScreen> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      EvidenceFolderFilesCubit.get(context).getStatistics(
        academicYearId: widget.academicYearId,
        termId: widget.termId,
        levelId: widget.levelId,
        departmentId: widget.departmentId,
      );
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

    final cubit = EvidenceFolderFilesCubit.get(context);
    
    final multipartFiles = await Future.wait(
      result.files
          .where((f) => f.path != null)
          .map((f) => dio.MultipartFile.fromFile(f.path!, filename: f.name)),
    );

    if (!mounted) return;
    for (var file in multipartFiles) {
      await cubit.uploadStatisticsFile(
        file: file,
        departmentId: widget.departmentId,
        academicYearId: widget.academicYearId,
        termId: widget.termId,
        levelId: widget.levelId,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<EvidenceFolderFilesCubit, EvidenceFolderFilesState>(
        listener: (context, state) {
          if (state is UploadEvidenceFilesSuccess) {
            showSnackBar(context, state.message, AppColors.green);
            EvidenceFolderFilesCubit.get(context).getStatistics(
              academicYearId: widget.academicYearId,
              termId: widget.termId,
              levelId: widget.levelId,
              departmentId: widget.departmentId,
            );
          }
          if (state is UploadEvidenceFilesFailure) {
            showSnackBar(context, state.error, AppColors.red);
          }
        },
        builder: (context, state) {
          final cubit = EvidenceFolderFilesCubit.get(context);
          final isUploading = state is UploadEvidenceFilesLoading;

          return Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(context, cubit.allFiles.length),
                  _buildToolbar(context, isUploading),
                  SizedBox(height: 15.h),
                  Expanded(child: _buildBody(context, state, cubit)),
                ],
              ),
              if (isUploading) ...[
                Positioned.fill(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                    child: Container(
                      color: Colors.white.withOpacity(0.4),
                    ),
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CustomLoading(),
                      SizedBox(height: 15.h),
                      Text(
                        'uploadingFiles'.tr(),
                        style: GoogleFonts.cairo(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF0F569E),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          );
        },
      ),
    );
  }

  Widget _buildHeader(BuildContext context, int count) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Container(
                padding: EdgeInsets.all(8.r),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F1FF),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(Icons.arrow_back_ios_new_rounded,
                    color: const Color(0xFF4285F4), size: 16.sp),
              ),
            ),
          ),
          SizedBox(width: 15.w),
          Container(
            padding: EdgeInsets.all(10.r),
            decoration: BoxDecoration(
              color: const Color(0xFF0F569E),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(Icons.analytics_rounded,
                color: Colors.white, size: 22.sp),
          ),
          SizedBox(width: 15.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Statistics'.tr(),
                  style: GoogleFonts.cairo(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1A1A1A))),
              Text('$count ${'files'.tr()}',
                  style: GoogleFonts.cairo(
                      fontSize: 12.sp, color: Colors.grey.shade500)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildToolbar(BuildContext context, bool isUploading) {
    final cubit = EvidenceFolderFilesCubit.get(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        children: [
          GestureDetector(
            onTap: isUploading ? null : _pickAndUpload,
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Container(
                height: 42.h,
                padding: EdgeInsets.symmetric(horizontal: 18.w),
                decoration: BoxDecoration(
                  color: const Color(0xFF4285F4),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Row(
                  children: [
                    isUploading
                        ? SizedBox(
                            width: 16.w,
                            height: 16.h,
                            child: const CircularProgressIndicator(
                                color: Colors.white, strokeWidth: 2))
                        : Icon(Icons.upload_file_rounded,
                            color: Colors.white, size: 18.sp),
                    SizedBox(width: 8.w),
                    Text(
                      'Upload File',
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
          SizedBox(width: 15.w),
          Expanded(
            child: Container(
              height: 42.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: TextField(
                controller: _searchController,
                onChanged: (v) => cubit.searchFiles(v),
                decoration: InputDecoration(
                  hintText: 'Search file...',
                  hintStyle: GoogleFonts.cairo(
                      color: Colors.grey.shade400, fontSize: 13.sp),
                  prefixIcon: Icon(Icons.search_rounded,
                      color: Colors.grey.shade400, size: 18.sp),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 8.h),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(
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
            onPressed: () => cubit.getStatistics(
              academicYearId: widget.academicYearId,
              termId: widget.termId,
              levelId: widget.levelId,
              departmentId: widget.departmentId,
            ),
          ),
        ),
      );
    }
    final list = cubit.filteredFiles;
    if (list.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.analytics_outlined,
                size: 64.sp, color: Colors.grey.shade300),
            SizedBox(height: 12.h),
            Text("No statistics files found",
                style: GoogleFonts.cairo(
                    fontSize: 16.sp, color: Colors.grey)),
          ],
        ),
      );
    }
    return ListView.separated(
      padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 20.h),
      itemCount: list.length,
      separatorBuilder: (_, __) => SizedBox(height: 10.h),
      itemBuilder: (context, index) {
        return EvidenceFolderFileItem(
          file: list[index],
          isArabic: context.locale.languageCode == 'ar',
          folderId: -1,
        );
      },
    );
  }
}
