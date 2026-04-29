import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qualiverse/features/analysis_files/data/model/evidence_file_model.dart';
import 'package:qualiverse/features/analysis_files/data/model/evidence_statistics_model.dart';
import 'package:qualiverse/features/analysis_files/presentation/controller/evidence_folder_files_state.dart';
import '../../data/service/evidence_folder_files_services.dart';

class EvidenceFolderFilesCubit extends Cubit<EvidenceFolderFilesState> {
  EvidenceFolderFilesCubit() : super(EvidenceFolderFilesInitial());

  static EvidenceFolderFilesCubit get(BuildContext context) =>
      BlocProvider.of(context);

  List<EvidenceFileModel> allFiles = [];
  List<EvidenceFileModel> filteredFiles = [];
  List<EvidenceStatisticsModel>? statistics;

  Future<void> getEvidenceFiles({required int folderId}) async {
    try {
      emit(EvidenceFolderFilesLoading());
      final files =
          await EvidenceFolderFilesServices.getEvidenceFilesByFolderId(
            folderId: folderId,
          );
      allFiles = files;
      filteredFiles = files;
      emit(EvidenceFolderFilesSuccess(files: files));
    } catch (e) {
      final msg = e.toString();
      if (msg.contains('No Internet')) {
        emit(
          EvidenceFolderFilesFailure(error: 'Check your internet connection'),
        );
      } else {
        emit(EvidenceFolderFilesFailure(error: msg));
      }
    }
  }

  void searchFiles(String query) {
    if (query.isEmpty) {
      filteredFiles = allFiles;
    } else {
      filteredFiles = allFiles
          .where(
            (file) =>
                file.fileName.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
    }
    emit(EvidenceFolderFilesSuccess(files: filteredFiles));
  }

  Future<void> uploadFiles({
    required int folderId,
    required List<MultipartFile> files,
    int? departmentId,
    required int academicYearId,
    required int semesterId,
    required int levelId,
  }) async {
    try {
      emit(UploadEvidenceFilesLoading());
      await EvidenceFolderFilesServices.uploadEvidenceFiles(
        folderId: folderId,
        files: files,
        departmentId: departmentId,
        academicYearId: academicYearId,
        semesterId: semesterId,
        levelId: levelId,
      );
      emit(UploadEvidenceFilesSuccess(message: 'Files uploaded successfully'));
      await getEvidenceFiles(folderId: folderId);
    } catch (e) {
      emit(UploadEvidenceFilesFailure(error: e.toString()));
    }
  }

  Future<void> deleteFile({required int fileId, required int folderId}) async {
    try {
      emit(DeleteEvidenceFileLoading());
      final msg = await EvidenceFolderFilesServices.deleteEvidenceFile(
        fileId: fileId,
      );
      emit(DeleteEvidenceFileSuccess(message: msg));
      await getEvidenceFiles(folderId: folderId);
    } catch (e) {
      emit(DeleteEvidenceFileFailure(error: e.toString()));
    }
  }

  Future<void> getStatistics({
    required int evidenceFolderId,
    int? departmentId,
    required int academicYearId,
    required int semesterId,
    required int levelId,
    required int courseId,
  }) async {
    try {
      emit(GetEvidenceStatisticsLoading());
      final stats = await EvidenceFolderFilesServices.getEvidenceStatistics(
        evidenceFolderId: evidenceFolderId,
        departmentId: departmentId,
        academicYearId: academicYearId,
        semesterId: semesterId,
        levelId: levelId,
        courseId: courseId,
      );
      statistics = stats;
      emit(GetEvidenceStatisticsSuccess(statistics: stats));
    } catch (e) {
      final cleanError = e.toString().replaceFirst('Exception: ', '').trim();
      emit(GetEvidenceStatisticsFailure(error: cleanError));
    }
  }
}
