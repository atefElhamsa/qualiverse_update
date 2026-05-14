import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class FolderFilesCubit extends Cubit<FolderFilesState> {
  FolderFilesCubit() : super(FolderFilesInitial());

  static FolderFilesCubit get(BuildContext context) => BlocProvider.of(context);

  List<FileModel> files = [];
  FileModel? selectedFile;

  void selectFile({required FileModel file}) {
    selectedFile = file;
    emit(FolderFilesSuccess(files: files, selectedFile: selectedFile));
  }

  Future<void> getFolderFiles({required int folderId}) async {
    try {
      emit(FolderFilesLoading());
      final files = await FileService.getFolderFiles(folderId: folderId);
      emit(FolderFilesSuccess(files: files.files!));
    } catch (e) {
      final msg = e.toString();
      if (msg.contains('No Internet')) {
        emit(FolderFilesFailure(error: 'Check your internet connection'));
      } else if (msg.contains('Unauthorized')) {
        await LoginStorage.clear();
        reset();
        emit(FolderFilesFailure(error: 'Session expired, please login again'));
      } else {
        emit(FolderFilesFailure(error: 'Something went wrong'));
      }
    }
  }

  void reset() {
    files = [];
    selectedFile = null;
    emit(FolderFilesInitial());
  }

  Future<void> uploadFiles({
    required int folderId,
    required List<MultipartFile> files,
  }) async {
    try {
      emit(UploadFilesLoading());
      final data = await FileService.uploadFilesToFolder(
        folderId: folderId,
        files: files,
      );
      emit(UploadFilesSuccess(data: data.data!));
      getFolderFiles(folderId: folderId);
    } catch (e) {
      final msg = e.toString();
      if (msg.contains('No Internet')) {
        emit(UploadFilesFailure(error: 'Check your internet connection'));
      } else if (msg.contains('Unauthorized')) {
        await LoginStorage.clear();
        reset();
        emit(UploadFilesFailure(error: 'Session expired, please login again'));
      } else {
        emit(
          UploadFilesFailure(error: msg.replaceFirst('Exception: ', '').trim()),
        );
      }
    }
  }

  Future<void> deleteFile({required int folderId, required int fileId}) async {
    try {
      emit(DeleteFileLoading(fileId: fileId));
      final message = await FileService.deleteFileFromFolder(
        folderId: folderId,
        fileId: fileId,
      );
      emit(DeleteFileSuccess(message: message));
      // Refresh the list from API after successful deletion
      await getFolderFiles(folderId: folderId);
    } catch (e) {
      final msg = e.toString();
      if (msg.contains('No Internet')) {
        emit(DeleteFileFailure(error: 'Check your internet connection'));
      } else if (msg.contains('Unauthorized')) {
        await LoginStorage.clear();
        reset();
        emit(DeleteFileFailure(error: 'Session expired, please login again'));
      } else {
        emit(
          DeleteFileFailure(error: msg.replaceFirst('Exception: ', '').trim()),
        );
      }
    }
  }
}
