import 'package:dio/dio.dart';
import '../../../../routing/all_routes_imports.dart';
import '../models/evidence_file_model.dart';
import '../models/evidence_folder_model.dart';

class EvidenceFolderFilesServices {
  static final Dio dio = ApiClient.dio;

  static Future<List<EvidenceFolderModel>> getEvidenceFolders() async {
    try {
      final response = await dio.get(EndPoints.evidenceFolders);
      final Map<String, dynamic> body = response.data;

      if (body['isSuccess'] != true) {
        throw Exception('Failed to load evidence folders');
      }
      final List list = body['data'] ?? [];
      return list.map((e) => EvidenceFolderModel.fromJson(e)).toList();
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) throw Exception('Unauthorized');
      throw Exception(
        e.response?.data?['message'] ??
            e.response?.data?['error'] ??
            'Server Error',
      );
    } catch (e) {
      throw Exception(e.toString().replaceFirst('Exception: ', '').trim());
    }
  }

  static Future<List<EvidenceFileModel>> getEvidenceFilesByFolderId({
    required int folderId,
  }) async {
    try {
      final response = await dio.get(
        EndPoints.getEvidenceFilesByFolderId(folderId: folderId),
      );
      final Map<String, dynamic> body = response.data;

      if (body['isSuccess'] != true) {
        throw Exception('Failed to load evidence files');
      }
      final List list = body['data'] ?? [];
      return list.map((e) => EvidenceFileModel.fromJson(e)).toList();
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) throw Exception('Unauthorized');
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

  static Future<void> uploadEvidenceFiles({
    required int folderId,
    required List<MultipartFile> files,
    int? departmentId,
    required int academicYearId,
    required int semesterId,
    required int levelId,
  }) async {
    try {
      for (var file in files) {
        final formData = FormData.fromMap({
          'File': file,
          'EvidenceFolderId': folderId,
          'DepartmentId': departmentId,
          'AcademicYearId': academicYearId,
          'SemesterId': semesterId,
          'LevelId': levelId,
        });

        await dio.post(
          EndPoints.uploadFileToEvidenceFolder(folderId: folderId),
          data: formData,
        );
      }
    } on DioException catch (e) {
      throw Exception(
        e.response?.data?['message'] ??
            e.response?.data?['error'] ??
            'Upload Failed',
      );
    } catch (e) {
      throw Exception(e.toString().replaceFirst('Exception: ', '').trim());
    }
  }

  static Future<String> deleteEvidenceFile({required int fileId}) async {
    try {
      final response = await dio.delete(
        EndPoints.deleteEvidenceFile(id: fileId),
      );
      final Map<String, dynamic> body = response.data;

      if (body['isSuccess'] != true) {
        throw Exception('Failed to delete evidence file');
      }
      return body['message'] ?? 'File deleted successfully';
    } on DioException catch (e) {
      throw Exception(
        e.response?.data?['message'] ??
            e.response?.data?['error'] ??
            'Delete Failed',
      );
    } catch (e) {
      throw Exception(e.toString().replaceFirst('Exception: ', '').trim());
    }
  }

}
