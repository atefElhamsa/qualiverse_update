import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class FolderFilesScreen extends StatefulWidget {
  final String folderName;
  final int folderId;

  const FolderFilesScreen({
    super.key,
    required this.folderName,
    required this.folderId,
  });

  @override
  State<FolderFilesScreen> createState() => _FolderFilesScreenState();
}

class _FolderFilesScreenState extends State<FolderFilesScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() => _searchQuery = _searchController.text.toLowerCase().trim());
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // ── Pick files and upload ──────────────────────────────────────────────────
  Future<void> _pickAndUpload() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (result == null || result.files.isEmpty) return;

    final multipartFiles = await Future.wait(
      result.files
          .where((f) => f.path != null)
          .map((f) => MultipartFile.fromFile(f.path!, filename: f.name)),
    );

    if (!mounted) return;
    await FolderFilesCubit.get(context).uploadFiles(
      folderId: widget.folderId,
      files: multipartFiles,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = context.locale.languageCode == 'ar';

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: BlocConsumer<FolderFilesCubit, FolderFilesState>(
        listener: (context, state) {
          if (state is UploadFilesSuccess) {
            showSnackBar(context, state.data.message, AppColors.green);
          }
          if (state is UploadFilesFailure) {
            showSnackBar(context, state.error, AppColors.red);
          }
          if (state is DeleteFileSuccess) {
            showSnackBar(context, state.message, AppColors.green);
          }
          if (state is DeleteFileFailure) {
            showSnackBar(context, state.error, AppColors.red);
          }
        },
        builder: (context, state) {
          final isUploading = state is UploadFilesLoading;

          // Filter files based on search query
          final allFiles =
              state is FolderFilesSuccess ? state.files : <FileModel>[];
          final filteredFiles = _searchQuery.isEmpty
              ? allFiles
              : allFiles
                  .where(
                    (f) =>
                        f.fileName.toLowerCase().contains(_searchQuery) ||
                        f.fileType.toLowerCase().contains(_searchQuery),
                  )
                  .toList();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FolderFilesHeader(
                folderName: widget.folderName,
                fileCount: allFiles.length,
              ),
              const SizedBox(height: 20),
              FolderFilesToolbar(
                isUploading: isUploading,
                onUpload: _pickAndUpload,
                searchController: _searchController,
              ),
              const SizedBox(height: 16),
              Expanded(
                child: _buildBody(context, state, isArabic, filteredFiles),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildBody(
    BuildContext context,
    FolderFilesState state,
    bool isArabic,
    List<FileModel> filteredFiles,
  ) {
    if (state is FolderFilesLoading || state is UploadFilesLoading) {
      return const CustomLoading();
    }

    if (state is FolderFilesFailure) {
      return RetryWidget(
        title: state.error,
        onPressed: () => FolderFilesCubit.get(context)
            .getFolderFiles(folderId: widget.folderId),
      );
    }

    if (state is FolderFilesSuccess || state is DeleteFileLoading) {
      return FolderFilesList(
        files: filteredFiles,
        isArabic: isArabic,
        folderId: widget.folderId,
      );
    }

    return const SizedBox();
  }
}
