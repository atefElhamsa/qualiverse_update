import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qualiverse/features/edit_files/data/models/evidence_file_model.dart';
import 'package:qualiverse/features/edit_files/presentation/controller/evidence_folder_files_state.dart';

abstract class BaseEvidenceCubit extends Cubit<EvidenceFolderFilesState> {
  BaseEvidenceCubit() : super(EvidenceFolderFilesInitial());

  List<EvidenceFileModel> allFiles = [];
  List<EvidenceFileModel> filteredFiles = [];

  void searchFiles(String query) {
    if (query.isEmpty) {
      filteredFiles = allFiles;
    } else {
      filteredFiles = allFiles
          .where((file) =>
              file.fileName.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    // We emit the success state of the concrete implementation
    emit(getSuccessState(filteredFiles));
  }

  EvidenceFolderFilesState getSuccessState(List<EvidenceFileModel> files);
}
