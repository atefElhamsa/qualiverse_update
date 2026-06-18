import 'package:dio/dio.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

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
      dynamic errorData = e.response?.data;
      if (errorData is Map) {
        final err = errorData['error'] ?? errorData['message'];
        if (err is Map && err.containsKey('description')) {
          throw Exception(err['description']);
        }
        if (errorData.containsKey('description')) {
          throw Exception(errorData['description']);
        }
        if (err is String) {
          throw Exception(err);
        }
      } else if (errorData is String) {
        throw Exception(errorData);
      }
      throw Exception('Server Error');
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
      dynamic errorData = e.response?.data;
      if (errorData is Map) {
        final err = errorData['error'] ?? errorData['message'];
        if (err is Map && err.containsKey('description')) {
          throw Exception(err['description']);
        }
        if (errorData.containsKey('description')) {
          throw Exception(errorData['description']);
        }
        if (err is String) {
          throw Exception(err);
        }
      } else if (errorData is String) {
        throw Exception(errorData);
      }
      throw Exception('Server Error');
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
      dynamic errorData = e.response?.data;
      if (errorData is Map) {
        final err = errorData['error'] ?? errorData['message'];
        if (err is Map && err.containsKey('description')) {
          throw Exception(err['description']);
        }
        if (errorData.containsKey('description')) {
          throw Exception(errorData['description']);
        }
        if (err is String) {
          throw Exception(err);
        }
      } else if (errorData is String) {
        throw Exception(errorData);
      }
      throw Exception('Server Error');
    } catch (e) {
      throw Exception(e.toString().replaceFirst('Exception: ', '').trim());
    }
  }
}
