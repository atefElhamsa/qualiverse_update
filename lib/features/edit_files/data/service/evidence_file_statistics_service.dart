import 'package:dio/dio.dart';
import 'package:qualiverse/core/network/api_client.dart';
import 'package:qualiverse/core/utils/end_points.dart';
import 'package:qualiverse/features/edit_files/data/models/evidence_file_model.dart';
import 'package:qualiverse/features/edit_files/data/models/evidence_file_statistics_model.dart';

class EvidenceFileStatisticsService {
  static final Dio dio = ApiClient.dio;

  static Future<List<EvidenceFileStatisticsModel>> getEvidenceFileStatistics({
    required int academicYearId,
    int? departmentId,
    required int levelId,
    required int termId,
  }) async {
    try {
      final response = await dio.get(
        "EvidenceFolder/statistics",
        queryParameters: {
          'departmentId': departmentId ?? 1,
          'academicYearId': academicYearId,
          'termId': termId,
          'levelId': levelId,
        },
      );
      final Map<String, dynamic> body = response.data;

      if (body['isSuccess'] != true) {
        throw Exception('Failed to load evidence files');
      }
      final List list = body['data'] ?? [];
      return list.map((e) => EvidenceFileStatisticsModel.fromJson(e)).toList();
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

  static Future<String> uploadEvidenceFileStatistics({
    required MultipartFile file,
    int? departmentId,
    required int academicYearId,
    required int termId,
    required int levelId,
  }) async {
    try {
      final formData = FormData.fromMap({
        'File': file,
        'DepartmentId': departmentId ?? 1,
        'AcademicYearId': academicYearId,
        'TermId': termId,
        'LevelId': levelId,
      });

      final response = await dio.post(
        EndPoints.uploadEvidenceStatistics,
        data: formData,
      );
      final Map<String, dynamic> body = response.data;

      if (body['isSuccess'] == true) {
        return 'File uploaded successfully';
      } else {
        throw Exception(body['message'] ?? 'Failed to upload evidence files');
      }
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

  static Future<List<EvidenceFileModel>> getEvidenceFileGeneralFolder({
    required int id,
    int? departmentId,
    required int academicYearId,
    required int termId,
    required int levelId,
    required int courseId,
  }) async {
    try {
      final response = await dio.get(
        EndPoints.getEvidenceFileGeneralFolder(
          id: id,
          departmentId: departmentId,
          academicYearId: academicYearId,
          termId: termId,
          levelId: levelId,
          courseId: courseId,
        ),
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

  static Future<String> uploadEvidenceFileGeneralFolder({
    required int id,
    required List<MultipartFile> files,
    int? departmentId,
    required int academicYearId,
    required int termId,
    required int levelId,
    required int courseId,
  }) async {
    try {
      final formData = FormData.fromMap({
        'Files': files,
        'EvidenceFolderId': id,
        'DepartmentId': departmentId ?? 1,
        'AcademicYearId': academicYearId,
        'TermId': termId,
        'LevelId': levelId,
        'CourseId': courseId,
      });

      final response = await dio.post(
        EndPoints.uploadEvidenceGeneral,
        data: formData,
      );
      final Map<String, dynamic> body = response.data;

      if (body['isSuccess'] == true) {
        return 'File uploaded successfully';
      } else {
        throw Exception(body['message'] ?? 'Failed to upload evidence files');
      }
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
}
