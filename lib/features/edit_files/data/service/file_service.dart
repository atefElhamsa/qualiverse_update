import 'package:dio/dio.dart';

import '../../../../routing/all_routes_imports.dart';
import '../models/upload_file_to_folder_model.dart';

class FileService {
  static final Dio dio = ApiClient.dio;

  static Future<FileResponse> getFolderFiles({required int folderId}) async {
    try {
      final response = await dio.get(
        EndPoints.getFolderFiles(folderId: folderId),
      );
      final Map<String, dynamic> body = response.data;

      final result = FileResponse.fromJson(body);
      if (!result.isSuccess) {
        throw Exception(result.error?.description ?? "Failed to load files");
      }
      return result;
    } on DioException catch (e) {
      // Unauthorized
      if (e.response?.statusCode == 401) {
        throw Exception('Unauthorized');
      }

      // Not Found
      if (e.response?.statusCode == 404) {
        throw Exception('Resource was not found');
      }

      // No Internet
      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.connectionTimeout) {
        throw Exception('No Internet Connection');
      }

      // Server error
      throw Exception(
        e.response?.data?['message'] ??
            e.response?.data?['error'] ??
            'Server Error',
      );
    } catch (e) {
      throw Exception(e.toString().replaceFirst('Exception: ', '').trim());
    }
  }

  static Future<UploadFileToFolderModel> uploadFilesToFolder({
    required int folderId,
    required List<MultipartFile> files,
  }) async {
    try {
      final formData = FormData.fromMap({'files': files});

      final response = await dio.post(
        EndPoints.uploadFileToFolder(folderId: folderId),
        data: formData,
        options: Options(contentType: 'multipart/form-data'),
      );

      final Map<String, dynamic> body = response.data;

      final result = UploadFileToFolderModel.fromJson(body);
      if (!result.isSuccess) {
        throw Exception(result.error?.description ?? "Failed to upload files");
      }

      return result;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw Exception('Unauthorized');
      }
      if (e.response?.statusCode == 404) {
        throw Exception('Resource was not found');
      }
      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.connectionTimeout) {
        throw Exception('No Internet Connection');
      }
      throw Exception(
        e.response?.data?['message'] ??
            e.response?.data?['error'] ??
            'Server Error',
      );
    } catch (e) {
      throw Exception(e.toString().replaceFirst('Exception: ', '').trim());
    }
  }

  static Future<String> deleteFileFromFolder({
    required int folderId,
    required int fileId,
  }) async {
    try {
      final response = await dio.delete(
        EndPoints.deleteFileFromFolder(folderId: folderId, fileId: fileId),
      );
      final Map<String, dynamic> body = response.data;
      if (body['isSuccess'] != true) {
        throw Exception(
          body['error']?['description'] ?? 'Failed to delete file',
        );
      }
      return body['data'] as String;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw Exception('Unauthorized');
      }
      if (e.response?.statusCode == 404) {
        throw Exception('Resource was not found');
      }
      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.connectionTimeout) {
        throw Exception('No Internet Connection');
      }
      throw Exception(
        e.response?.data?['message'] ??
            e.response?.data?['error'] ??
            'Server Error',
      );
    } catch (e) {
      throw Exception(e.toString().replaceFirst('Exception: ', '').trim());
    }
  }
}
