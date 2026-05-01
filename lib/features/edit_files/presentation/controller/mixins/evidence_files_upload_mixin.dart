import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qualiverse/features/edit_files/presentation/controller/evidence_folder_files_state.dart';

mixin EvidenceFilesUploadMixin on Cubit<EvidenceFolderFilesState> {
  Future<void> pickAndUploadEvidenceFiles({
    required int folderId,
    int? departmentId,
    int? academicYearId,
    int? termId,
    int? levelId,
    int? courseId,
  }) async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (result == null || result.files.isEmpty) return;

    final multipartFiles = result.files.map((file) {
      return MultipartFile.fromFileSync(file.path!, filename: file.name);
    }).toList();

    // The actual upload call depends on the Cubit implementation
    // We will cast to EvidenceFolderFilesCubit to access its methods
  }
}
