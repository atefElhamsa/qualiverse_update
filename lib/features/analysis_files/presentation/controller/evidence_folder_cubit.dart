import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../routing/all_routes_imports.dart';

class EvidenceFolderCubit extends Cubit<EvidenceFolderState> {
  EvidenceFolderCubit() : super(EvidenceFolderInitial());

  static EvidenceFolderCubit get(BuildContext context) =>
      BlocProvider.of(context);

  List<EvidenceFolderModel> evidenceFolders = [];
  EvidenceFolderModel? selectedEvidenceFolder;

  void selectEvidenceFolder({required EvidenceFolderModel evidenceFolder}) {
    selectedEvidenceFolder = evidenceFolder;

    emit(
      EvidenceFolderSuccess(
        evidenceFolders: evidenceFolders,
        selectedEvidenceFolder: selectedEvidenceFolder,
      ),
    );
  }

  Future<void> fetchEvidenceFolders() async {
    emit(EvidenceFolderLoading());
    try {
      final data = await AnalysisFilesServices.getEvidenceFolders();
      evidenceFolders = data;

      emit(
        EvidenceFolderSuccess(
          evidenceFolders: evidenceFolders,
          selectedEvidenceFolder: selectedEvidenceFolder,
        ),
      );
    } catch (e) {
      final msg = e.toString();

      if (msg.contains('No Internet')) {
        emit(EvidenceFolderError(message: 'Check your internet connection'));
      } else if (msg.contains('Unauthorized')) {
        await LoginStorage.clear();
        reset();
        emit(
          EvidenceFolderError(message: 'Session expired, please login again'),
        );
      } else {
        emit(EvidenceFolderError(message: 'Something went wrong'));
      }
    }
  }

  void reset() {
    evidenceFolders = [];
    selectedEvidenceFolder = null;
    emit(EvidenceFolderInitial());
  }
}
