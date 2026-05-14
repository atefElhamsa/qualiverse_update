import 'package:dio/dio.dart' as dio;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class EvidenceFolderFilesScreen extends StatefulWidget {
  final String folderName;
  final int folderId;
  final int? departmentId;
  final int? academicYearId;
  final int? termId;
  final int? levelId;

  const EvidenceFolderFilesScreen({
    super.key,
    required this.folderName,
    required this.folderId,
    this.departmentId,
    this.academicYearId,
    this.termId,
    this.levelId,
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
      EvidenceFolderFilesCubit.get(
        context,
      ).getEvidenceFiles(folderId: widget.folderId);
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
    await cubit.uploadFiles(
      folderId: widget.folderId,
      files: multipartFiles,
      departmentId: widget.departmentId!,
      academicYearId: widget.academicYearId!,
      semesterId: widget.termId!,
      levelId: widget.levelId!,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<EvidenceFolderFilesCubit, EvidenceFolderFilesState>(
        listener: (context, state) {
          if (state is UploadEvidenceFilesSuccess) {
            showSnackBar(context, state.message, AppColors.green);
            EvidenceFolderFilesCubit.get(
              context,
            ).getEvidenceFiles(folderId: widget.folderId);
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
          final isUploading = state is UploadEvidenceFilesLoading;

          return Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BuildHeaderFolderFiles(
                    count: cubit.allFiles.length,
                    folderName: widget.folderName,
                  ),
                  BuildToolbarFolderFiles(
                    isUploading: isUploading,
                    searchController: _searchController,
                    onPickAndUpload: _pickAndUpload,
                  ),
                  SizedBox(height: 15.h),
                  Expanded(
                    child: BuildBodyFolderFiles(
                      cubit: cubit,
                      folderId: widget.folderId,
                    ),
                  ),
                ],
              ),
              if (isUploading)
                Container(
                  color: Colors.white.withOpacity(0.4),
                  child: const Center(child: CustomLoading()),
                ),
            ],
          );
        },
      ),
    );
  }
}
