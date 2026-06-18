import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:qualiverse/features/ai_report/data/models/ai_report_publish.dart';
import '../../../../routing/all_routes_imports.dart';

class EvidenceFolderFilesServices {
  static final Dio dio = ApiClient.dio;

  static Future<EvidenceFolderResponseModel> getEvidenceFolders() async {
    try {
      final response = await dio.get(EndPoints.evidenceFolders);
      final Map<String, dynamic> body = response.data;

      final result = EvidenceFolderResponseModel.fromJson(body);

      if (!result.isSuccess) {
        throw Exception(
          result.error?.description ?? "Failed to load evidence folders",
        );
      }
      return result;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) throw Exception('Unauthorized');
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

  static Future<EvidenceFileResponse> getEvidenceFilesByFolderId({
    required int folderId,
  }) async {
    try {
      final response = await dio.get(
        EndPoints.getEvidenceFilesByFolderId(folderId: folderId),
      );
      final Map<String, dynamic> body = response.data;
      final result = EvidenceFileResponse.fromJson(body);

      if (!result.isSuccess) {
        throw Exception(result.error?.description ?? "Failed to load files");
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
        final Map<String, dynamic> dataMap = {
          'File': file,
          'EvidenceFolderId': folderId,
          'AcademicYearId': academicYearId,
          'SemesterId': semesterId,
          'LevelId': levelId,
        };
        if (departmentId != null) {
          dataMap['DepartmentId'] = departmentId;
        }
        final formData = FormData.fromMap(dataMap);

        await dio.post(
          EndPoints.uploadFileToEvidenceFolder(folderId: folderId),
          data: formData,
        );
      }
    } on DioException catch (e) {
      final errorData =
          e.response?.data?['error'] ?? e.response?.data?['message'];
      if (errorData is Map && errorData.containsKey('description')) {
        throw Exception(errorData['description']);
      }
      throw Exception(errorData?.toString() ?? 'Upload Failed');
    } catch (e) {
      throw Exception(e.toString().replaceFirst('Exception: ', '').trim());
    }
  }

  static Future<AiReportPublishResponse> deleteEvidenceFile({
    required int fileId,
  }) async {
    try {
      final response = await dio.delete(
        EndPoints.deleteEvidenceFile(id: fileId),
      );
      var body = response.data;
      final result = AiReportPublishResponse.fromJson(body);

      if (!result.isSuccess) {
        throw Exception(result.error?.description ?? 'Delete Failed');
      }
      return result;
    } on DioException catch (e) {
      if (e.response?.data != null) {
        dynamic errorData = e.response!.data;

        if (errorData is String) {
          try {
            errorData = jsonDecode(errorData);
          } catch (_) {}
        }

        if (errorData is Map) {
          if (errorData.containsKey('description')) {
            throw Exception(errorData['description']);
          }
          final err = errorData['error'] ?? errorData['message'];
          if (err is Map && err.containsKey('description')) {
            throw Exception(err['description']);
          } else if (err is String) {
            final regex = RegExp(r'description:\s*(.*?)(?:,|})');
            final match = regex.firstMatch(err);
            if (match != null && match.group(1) != null) {
              throw Exception(match.group(1)!.trim());
            }
            throw Exception(err);
          }
        } else if (errorData is String) {
          final regex = RegExp(r'description:\s*(.*?)(?:,|})');
          final match = regex.firstMatch(errorData);
          if (match != null && match.group(1) != null) {
            throw Exception(match.group(1)!.trim());
          }
          throw Exception(errorData);
        }

        throw Exception("Server error");
      }

      throw Exception("No Internet Connection");
    } catch (e) {
      throw Exception(e.toString().replaceFirst('Exception: ', '').trim());
    }
  }
}
