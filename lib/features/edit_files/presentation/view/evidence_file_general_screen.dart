import 'package:dio/dio.dart' as dio;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class EvidenceFileGeneralScreen extends StatefulWidget {
  final int folderId;
  final String folderName;
  final int academicYearId;
  final int termId;
  final int levelId;
  final int courseId;
  final int? departmentId;

  const EvidenceFileGeneralScreen({
    super.key,
    required this.folderId,
    required this.folderName,
    required this.academicYearId,
    required this.termId,
    required this.levelId,
    required this.courseId,
    this.departmentId,
  });

  @override
  State<EvidenceFileGeneralScreen> createState() =>
      _EvidenceFileGeneralScreenState();
}

class _EvidenceFileGeneralScreenState extends State<EvidenceFileGeneralScreen> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      EvidenceFolderFilesCubit.get(context).getGeneralFiles(
        id: widget.folderId,
        academicYearId: widget.academicYearId,
        termId: widget.termId,
        levelId: widget.levelId,
        courseId: widget.courseId,
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
    List<dio.MultipartFile> multipartFiles = [];

    for (var f in result.files) {
      if (f.path != null) {
        final multipartFile = await dio.MultipartFile.fromFile(
          f.path!,
          filename: f.name,
        );
        multipartFiles.add(multipartFile);
      }
    }

    if (multipartFiles.isNotEmpty) {
      await cubit.uploadGeneralFile(
        id: widget.folderId,
        files: multipartFiles,
        departmentId: widget.departmentId,
        academicYearId: widget.academicYearId,
        termId: widget.termId,
        levelId: widget.levelId,
        courseId: widget.courseId,
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
            showSnackBar(context, state.message, Colors.green);
          }
          if (state is UploadEvidenceFilesFailure) {
            showSnackBar(context, state.error, Colors.red);
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
                  BuildHeaderFileGeneral(
                    folderName: widget.folderName,
                    count: cubit.allFiles.length,
                  ),
                  BuildToolbarFileGeneral(
                    isUploading: isUploading,
                    searchController: _searchController,
                    pickAndUpload: _pickAndUpload,
                  ),
                  SizedBox(height: 15.h),
                  Expanded(
                    child: BuildBodyFileGeneral(
                      cubit: cubit,
                      folderId: widget.folderId,
                      academicYearId: widget.academicYearId,
                      termId: widget.termId,
                      levelId: widget.levelId,
                      courseId: widget.courseId,
                      departmentId: widget.departmentId,
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
