import 'dart:io';
import 'package:dio/dio.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';
import 'package:qualiverse/features/ai_report/data/models/ai_report_extract_response_model.dart';
import '../models/ai_report_status_model.dart';
import '../models/ai_report_job_status_model.dart';

class AiReportService {
  static final Dio dio = ApiClient.dio;

  static Future<AiReportHealthModel> getHealthStatus() async {
    try {
      final response = await dio.get(EndPoints.aiReportHealth);
      return AiReportHealthModel.fromJson(
        response.data as Map<String, dynamic>,
      );
    } on DioException catch (e) {
      throw Exception(_extractDioError(e));
    } catch (e) {
      throw Exception(e.toString().replaceFirst('Exception: ', '').trim());
    }
  }

  static Future<AiReportProvidersModel> getProviders() async {
    try {
      final response = await dio.get(EndPoints.aiReportProviders);
      return AiReportProvidersModel.fromJson(
        response.data as Map<String, dynamic>,
      );
    } on DioException catch (e) {
      throw Exception(_extractDioError(e));
    } catch (e) {
      throw Exception(e.toString().replaceFirst('Exception: ', '').trim());
    }
  }

  static Future<AiReportExtractResponse> extractReport({
    String? provider,
    String? courseNature,
    required File surveyPdf,
    required File descriptionPdf,
    required File statsPdf,
  }) async {
    try {
      final queryParams = <String, dynamic>{};
      if (provider != null && provider.isNotEmpty) {
        queryParams['provider'] = provider;
      }
      if (courseNature != null && courseNature.isNotEmpty) {
        queryParams['courseNature'] = courseNature;
      }

      final formData = FormData.fromMap({
        'surveyPdf': await MultipartFile.fromFile(
          surveyPdf.path,
          filename: surveyPdf.path.split(RegExp(r'[\\/]')).last,
        ),
        'descriptionPdf': await MultipartFile.fromFile(
          descriptionPdf.path,
          filename: descriptionPdf.path.split(RegExp(r'[\\/]')).last,
        ),
        'statsPdf': await MultipartFile.fromFile(
          statsPdf.path,
          filename: statsPdf.path.split(RegExp(r'[\\/]')).last,
        ),
      });

      final response = await dio.post(
        EndPoints.aiReportExtract,
        data: formData,
        queryParameters: queryParams.isNotEmpty ? queryParams : null,
        options: Options(
          receiveTimeout: const Duration(minutes: 3),
          sendTimeout: const Duration(minutes: 2),
        ),
      );

      final Map<String, dynamic> body = response.data as Map<String, dynamic>;
      final extractResponse = AiReportExtractResponse.fromJson(body);
      if (extractResponse.isSuccess) {
        return extractResponse;
      } else {
        throw Exception(body['message'] ?? 'Extraction failed');
      }
    } on DioException catch (e) {
      throw Exception(_extractDioError(e));
    } catch (e) {
      throw Exception(e.toString().replaceFirst('Exception: ', '').trim());
    }
  }

  static Future<Map<String, dynamic>> submitReport(
    Map<String, dynamic> reportData,
  ) async {
    try {
      final response = await dio.post(
        EndPoints.aiReportSubmit,
        data: reportData,
        options: Options(
          receiveTimeout: const Duration(minutes: 3),
          sendTimeout: const Duration(minutes: 2),
        ),
      );

      final Map<String, dynamic> body = response.data as Map<String, dynamic>;
      if (body['isSuccess'] == true) {
        return body;
      } else {
        throw Exception(body['message'] ?? 'Submission failed');
      }
    } on DioException catch (e) {
      throw Exception(_extractDioError(e));
    } catch (e) {
      throw Exception(e.toString().replaceFirst('Exception: ', '').trim());
    }
  }

  // ──────────────────────────── Report Status ──────────────────────────────
  static Future<AiReportJobStatusResponse> getReportStatus(String jobId) async {
    try {
      final response = await dio.get(EndPoints.aiReportStatus(jobId));
      final Map<String, dynamic> body = response.data as Map<String, dynamic>;
      return AiReportJobStatusResponse.fromJson(body);
    } on DioException catch (e) {
      throw Exception(_extractDioError(e));
    } catch (e) {
      throw Exception(e.toString().replaceFirst('Exception: ', '').trim());
    }
  }

  // ──────────────────────────── Download Report ──────────────────────────────
  static Future<String> downloadReportPdf(String jobId, String savePath) async {
    try {
      await dio.download(
        EndPoints.aiReportDownloadPdf(jobId),
        savePath,
        options: Options(receiveTimeout: const Duration(minutes: 5)),
      );
      return savePath;
    } on DioException catch (e) {
      throw Exception(_extractDioError(e));
    } catch (e) {
      throw Exception(e.toString().replaceFirst('Exception: ', '').trim());
    }
  }

  static Future<String> downloadReportDocx(
    String jobId,
    String savePath,
  ) async {
    try {
      await dio.download(
        EndPoints.aiReportDownloadDocx(jobId),
        savePath,
        options: Options(receiveTimeout: const Duration(minutes: 5)),
      );
      return savePath;
    } on DioException catch (e) {
      throw Exception(_extractDioError(e));
    } catch (e) {
      throw Exception(e.toString().replaceFirst('Exception: ', '').trim());
    }
  }

  // ──────────────────────────── Error helper ──────────────────────────────
  static String _extractDioError(DioException e) {
    if (e.response?.statusCode == 401) return 'Unauthorized';
    if (e.type == DioExceptionType.connectionError ||
        e.type == DioExceptionType.connectionTimeout) {
      return 'No Internet Connection';
    }
    final errorData = e.response?.data?['error'];
    if (errorData is Map) {
      return errorData['description'] ??
          errorData['message'] ??
          errorData.toString();
    }
    if (errorData is String) return errorData;
    if (e.response?.data?['message'] != null) {
      return e.response!.data['message'].toString();
    }
    return 'Server Error';
  }
}
