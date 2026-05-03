import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qualiverse/features/edit_files/data/models/evidence_file_model.dart';
import 'package:qualiverse/features/edit_files/data/models/evidence_file_statistics_model.dart';
import 'package:qualiverse/features/edit_files/data/service/evidence_file_statistics_service.dart';
import 'package:qualiverse/features/edit_files/data/service/evidence_folder_files_services.dart';
import 'evidence_folder_files_state.dart';

enum EvidenceFolderType { standard, statistics, general }

class EvidenceFolderFilesCubit extends Cubit<EvidenceFolderFilesState> {
  EvidenceFolderFilesCubit() : super(EvidenceFolderFilesInitial());

  static EvidenceFolderFilesCubit get(BuildContext context) => BlocProvider.of(context);

  List<EvidenceFileModel> allFiles = [];
  List<EvidenceFileModel> filteredFiles = [];
  List<EvidenceFileStatisticsModel> statisticsFiles = [];

  int? lastYearId;
  int? lastTermId;
  int? lastLevelId;
  int? lastDeptId;
  int? lastCourseId;
  int? lastFolderId;
  EvidenceFolderType currentType = EvidenceFolderType.standard;

  Future<void> getEvidenceFiles({required int folderId}) async {
    currentType = EvidenceFolderType.standard;
    lastFolderId = folderId;
    lastCourseId = null;
    try {
      emit(EvidenceFolderFilesLoading());
      final files = await EvidenceFolderFilesServices.getEvidenceFilesByFolderId(
        folderId: folderId,
      );
      allFiles = files.files!;
      filteredFiles = files.files!;
      emit(EvidenceFolderFilesSuccess(files: files.files!));
    } catch (e) {
      emit(EvidenceFolderFilesFailure(error: e.toString().replaceFirst('Exception: ', '').trim()));
    }
  }

  void searchFiles(String query) {
    if (query.isEmpty) {
      filteredFiles = allFiles;
    } else {
      filteredFiles = allFiles
          .where((file) =>
              file.fileName.toLowerCase().contains(query.toLowerCase()))
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
      emit(UploadEvidenceFilesFailure(error: e.toString().replaceFirst('Exception: ', '').trim()));
    }
  }

  Future<void> deleteFile({required int fileId, required int folderId}) async {
    try {
      emit(DeleteEvidenceFileLoading());
      final msg = await EvidenceFolderFilesServices.deleteEvidenceFile(
        fileId: fileId,
      );
      emit(DeleteEvidenceFileSuccess(message: msg));

      // Refresh logic based on the TYPE we are currently viewing
      switch (currentType) {
        case EvidenceFolderType.statistics:
          if (lastYearId != null) {
            await getStatistics(
              academicYearId: lastYearId!,
              termId: lastTermId!,
              levelId: lastLevelId!,
              departmentId: lastDeptId,
            );
          }
          break;
        case EvidenceFolderType.general:
          await getGeneralFiles(
            id: folderId,
            academicYearId: lastYearId!,
            termId: lastTermId!,
            levelId: lastLevelId!,
            courseId: lastCourseId!,
            departmentId: lastDeptId,
          );
          break;
        case EvidenceFolderType.standard:
          await getEvidenceFiles(folderId: folderId);
          break;
      }
    } catch (e) {
      emit(DeleteEvidenceFileFailure(error: e.toString().replaceFirst('Exception: ', '').trim()));
    }
  }

  Future<void> getStatistics({
    required int academicYearId,
    int? departmentId,
    required int levelId,
    required int termId,
  }) async {
    currentType = EvidenceFolderType.statistics;
    lastYearId = academicYearId;
    lastTermId = termId;
    lastLevelId = levelId;
    lastDeptId = departmentId;
    lastCourseId = null;
    try {
      emit(GetEvidenceStatisticsLoading());
      final files =
          await EvidenceFileStatisticsService.getEvidenceFileStatistics(
        academicYearId: academicYearId,
        departmentId: departmentId,
        levelId: levelId,
        termId: termId,
      );
      statisticsFiles = files.data!;
      allFiles = files.data!.map((e) => e.toEvidenceFileModel()).toList();
      filteredFiles = allFiles;
      emit(GetEvidenceStatisticsSuccess(statistics: files.data!));
    } catch (e) {
      emit(GetEvidenceStatisticsFailure(error: e.toString().replaceFirst('Exception: ', '').trim()));
    }
  }

  Future<void> uploadStatisticsFile({
    required MultipartFile file,
    int? departmentId,
    required int academicYearId,
    required int termId,
    required int levelId,
  }) async {
    try {
      emit(UploadEvidenceFilesLoading());
      final message =
          await EvidenceFileStatisticsService.uploadEvidenceFileStatistics(
        file: file,
        departmentId: departmentId,
        academicYearId: academicYearId,
        termId: termId,
        levelId: levelId,
      );
      emit(UploadEvidenceFilesSuccess(message: message));
      await getStatistics(
        academicYearId: academicYearId,
        termId: termId,
        levelId: levelId,
        departmentId: departmentId,
      );
    } catch (e) {
      emit(UploadEvidenceFilesFailure(error: e.toString().replaceFirst('Exception: ', '').trim()));
    }
  }

  Future<void> getGeneralFiles({
    required int id,
    int? departmentId,
    required int academicYearId,
    required int termId,
    required int levelId,
    required int courseId,
  }) async {
    currentType = EvidenceFolderType.general;
    lastYearId = academicYearId;
    lastTermId = termId;
    lastLevelId = levelId;
    lastDeptId = departmentId;
    lastCourseId = courseId;
    lastFolderId = id;
    try {
      emit(EvidenceFolderFilesLoading());
      final files =
          await EvidenceFileStatisticsService.getEvidenceFileGeneralFolder(
        id: id,
        departmentId: departmentId,
        academicYearId: academicYearId,
        termId: termId,
        levelId: levelId,
        courseId: courseId,
      );
      allFiles = files;
      filteredFiles = files;
      emit(EvidenceFolderFilesSuccess(files: files));
    } catch (e) {
      emit(EvidenceFolderFilesFailure(error: e.toString().replaceFirst('Exception: ', '').trim()));
    }
  }

  Future<void> uploadGeneralFile({
    required int id,
    required List<MultipartFile> files,
    int? departmentId,
    required int academicYearId,
    required int termId,
    required int levelId,
    required int courseId,
  }) async {
    try {
      emit(UploadEvidenceFilesLoading());
      final message =
          await EvidenceFileStatisticsService.uploadEvidenceFileGeneralFolder(
        id: id,
        files: files,
        departmentId: departmentId,
        academicYearId: academicYearId,
        termId: termId,
        levelId: levelId,
        courseId: courseId,
      );
      emit(UploadEvidenceFilesSuccess(message: message));
      await getGeneralFiles(
        id: id,
        academicYearId: academicYearId,
        termId: termId,
        levelId: levelId,
        courseId: courseId,
        departmentId: departmentId,
      );
    } catch (e) {
      emit(UploadEvidenceFilesFailure(error: e.toString().replaceFirst('Exception: ', '').trim()));
    }
  }
}
