import 'package:dio/dio.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class EvidenceFileStatisticsService {
  static final Dio dio = ApiClient.dio;

  static Future<StatisticsPreviewResponse> previewStatistics({
    required MultipartFile file,
    required int academicYearId,
    int? departmentId,
    required int levelId,
    required int termId,
    String? lang,
  }) async {
    try {
      final formData = FormData.fromMap({
        "File": file,
        "AcademicYearId": academicYearId,
        "TermId": termId,
        "LevelId": levelId,
        "DepartmentId": ?departmentId,
      });

      final response = await dio.post(
        EndPoints.previewStatistics,
        data: formData,
        options: lang != null
            ? Options(headers: {'Accept-Language': lang})
            : null,
      );

      return StatisticsPreviewResponse.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) throw Exception('Unauthorized');
      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.connectionTimeout) {
        throw Exception('No Internet Connection');
      }
      final errorData =
          e.response?.data?['error'] ?? e.response?.data?['message'];
      if (errorData is Map && errorData.containsKey('description')) {
        throw Exception(errorData['description']);
      }
      throw Exception(errorData?.toString() ?? 'Server Error');
    } catch (e) {
      throw Exception(e.toString().replaceFirst('Exception: ', '').trim());
    }
  }

  static Future<bool> confirmStatistics({
    required String previewId,
    List<Map<String, dynamic>>? courseOverrides,
  }) async {
    try {
      final response = await dio.post(
        EndPoints.confirmStatistics,
        data: {
          "previewId": previewId,
          "courseOverrides": courseOverrides ?? [],
        },
      );
      return response.data['isSuccess'] ?? false;
    } catch (e) {
      return false;
    }
  }

  static Future<EvidenceFileStatisticsModelResponse> getEvidenceFileStatistics({
    required int academicYearId,
    int? departmentId,
    required int levelId,
    required int termId,
  }) async {
    try {
      final response = await dio.get(
        EndPoints.getEvidenceStatistics(
          departmentId: departmentId,
          academicYearId: academicYearId,
          termId: termId,
          levelId: levelId,
        ),
      );
      final Map<String, dynamic> body = response.data;

      final result = EvidenceFileStatisticsModelResponse.fromJson(body);

      if (!result.isSuccess) {
        throw Exception(
          result.error?.description ?? "Failed to load evidence files",
        );
      }
      return result;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) throw Exception('Unauthorized');
      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.connectionTimeout) {
        throw Exception('No Internet Connection');
      }
      final errorData =
          e.response?.data?['error'] ?? e.response?.data?['message'];
      if (errorData is Map && errorData.containsKey('description')) {
        throw Exception(errorData['description']);
      }
      throw Exception(errorData?.toString() ?? 'Server Error');
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
      final Map<String, dynamic> dataMap = {
        'File': file,
        'AcademicYearId': academicYearId,
        'TermId': termId,
        'LevelId': levelId,
      };
      if (departmentId != null) {
        dataMap['DepartmentId'] = departmentId;
      }
      final formData = FormData.fromMap(dataMap);

      final response = await dio.post(
        EndPoints.uploadEvidenceStatistics,
        data: formData,
      );
      final Map<String, dynamic> body = response.data;

      if (body['isSuccess'] == true) {
        return 'File uploaded successfully';
      } else {
        final errorData = body['error'] ?? body['message'];
        if (errorData is Map && errorData.containsKey('description')) {
          throw Exception(errorData['description']);
        }
        throw Exception(
          errorData?.toString() ?? 'Failed to upload evidence files',
        );
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) throw Exception('Unauthorized');
      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.connectionTimeout) {
        throw Exception('No Internet Connection');
      }
      final errorData =
          e.response?.data?['error'] ?? e.response?.data?['message'];
      if (errorData is Map && errorData.containsKey('description')) {
        throw Exception(errorData['description']);
      }
      throw Exception(errorData?.toString() ?? 'Server Error');
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
      final errorData =
          e.response?.data?['error'] ?? e.response?.data?['message'];
      if (errorData is Map && errorData.containsKey('description')) {
        throw Exception(errorData['description']);
      }
      throw Exception(errorData?.toString() ?? 'Server Error');
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
      final Map<String, dynamic> dataMap = {
        'Files': files,
        'EvidenceFolderId': id,
        'AcademicYearId': academicYearId,
        'TermId': termId,
        'LevelId': levelId,
        'CourseId': courseId,
      };
      if (departmentId != null) {
        dataMap['DepartmentId'] = departmentId;
      }
      final formData = FormData.fromMap(dataMap);

      final response = await dio.post(
        EndPoints.uploadEvidenceGeneral,
        data: formData,
      );
      final Map<String, dynamic> body = response.data;

      if (body['isSuccess'] == true) {
        return 'File uploaded successfully';
      } else {
        final errorData = body['error'] ?? body['message'];
        if (errorData is Map && errorData.containsKey('description')) {
          throw Exception(errorData['description']);
        }
        throw Exception(
          errorData?.toString() ?? 'Failed to upload evidence files',
        );
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) throw Exception('Unauthorized');
      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.connectionTimeout) {
        throw Exception('No Internet Connection');
      }
      final errorData =
          e.response?.data?['error'] ?? e.response?.data?['message'];
      if (errorData is Map && errorData.containsKey('description')) {
        throw Exception(errorData['description']);
      }
      throw Exception(errorData?.toString() ?? 'Server Error');
    } catch (e) {
      throw Exception(e.toString().replaceFirst('Exception: ', '').trim());
    }
  }
}
