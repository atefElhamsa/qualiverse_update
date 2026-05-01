import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qualiverse/features/edit_files/presentation/controller/evidence_folder_files_state.dart';

mixin EvidenceActionsMixin on Cubit<EvidenceFolderFilesState> {
  Future<List<MultipartFile>> pickFiles() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (result == null || result.files.isEmpty) return [];

    return result.files.map((file) {
      return MultipartFile.fromFileSync(file.path!, filename: file.name);
    }).toList();
  }
}
