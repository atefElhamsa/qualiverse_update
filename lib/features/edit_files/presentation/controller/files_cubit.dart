import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:qualiverse/features/edit_files/edit_files_imports/edit_files_imports.dart';

class FilesCubit extends Cubit<FilesState> {
  FilesCubit() : super(FilesInitial());

  List<FileModel> get files {
    if (state is FilesLoaded) {
      return (state as FilesLoaded).files;
    }
    return [];
  }

  // ===== Helpers

  String currentDate() {
    return DateFormat('dd/MM/yyyy').format(DateTime.now());
  }

  FileModel mapToFileModel(PlatformFile file) {
    return FileModel(
      name: file.name,
      owner: "Current User",
      date: currentDate(),
      fileSize: FileSizeFormatter.formatFileSize(file.size),
    );
  }

  // ===== Pick =====

  Future<void> pickFile() async {
    try {
      emit(FilesLoading());
      final result = await FilePicker.platform.pickFiles(allowMultiple: true);

      if (result == null) {
        emit(FilesLoaded(files: files));
        return;
      }

      final newFiles = result.files.map(mapToFileModel).toList();

      final updatedFiles = [...newFiles, ...files];
      emit(FilesLoaded(files: updatedFiles));
    } catch (error) {
      emit(FilesError(errorMessage: error.toString()));
    }
  }

  // ===== Delete =====

  void deleteFile(FileModel file) {
    final updatedFiles = files
        .where((f) => f.name != file.name || f.date != file.date)
        .toList();

    emit(FilesLoaded(files: updatedFiles));
  }

  // ===== Edit (Replace) =====

  Future<void> editFile(FileModel oldFile) async {
    emit(FilesLoading());
    final result = await FilePicker.platform.pickFiles();

    if (result == null) {
      emit(FilesLoaded(files: files));
      return;
    }

    final newFile = mapToFileModel(result.files.first);

    final updatedFiles = files.map((file) {
      if (file.name == oldFile.name && file.date == oldFile.date) {
        return newFile;
      }
      return file;
    }).toList();

    emit(FilesLoaded(files: updatedFiles));
  }
}
