import 'dart:io';

import 'package:dio/dio.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class IndicatorServices {
  static final Dio dio = ApiClient.dio;

  static Future<List<IndicatorModel>> getIndicators({
    required int criterionId,
  }) async {
    try {
      final response = await dio.get(
        EndPoints.indicatorsByCriterionId(criterionId: criterionId),
      );

      final data = response.data;

      final List list = data is List ? data : data['data'];

      return list.map((e) => IndicatorModel.fromJson(e)).toList();
    } on DioException catch (e) {
      // Unauthorized
      if (e.response?.statusCode == 401) {
        throw Exception('Unauthorized');
      }

      // No Internet
      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.connectionTimeout) {
        throw Exception('No Internet Connection');
      }

      // Server Error
      throw Exception(
        e.response?.data?['message'] ??
            e.response?.data?['error'] ??
            'Server Error',
      );
    } catch (e) {
      throw Exception(e.toString().replaceFirst('Exception: ', '').trim());
    }
  }

  static Future<IndicatorPdfFile> uploadIndicatorFile({
    required int indicatorId,
    required File file,
  }) async {
    try {
      final formData = FormData.fromMap({
        'indicatorId': indicatorId,
        'indicatorFile': await MultipartFile.fromFile(
          file.path,
          filename: file.path.split('/').last,
        ),
      });

      final response = await dio.put(
        EndPoints.indicator,
        data: formData,
        options: Options(headers: {'Content-Type': 'multipart/form-data'}),
      );

      return IndicatorPdfFile.fromJson(response.data);
    } on DioException catch (e) {
      // Unauthorized
      if (e.response?.statusCode == 401) {
        throw Exception('Unauthorized');
      }

      // No Internet
      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.connectionTimeout) {
        throw Exception('No Internet Connection');
      }

      // Server / Validation error
      throw Exception(
        e.response?.data?['message'] ??
            e.response?.data?['error'] ??
            'Upload Failed',
      );
    } catch (e) {
      throw Exception(e.toString().replaceFirst('Exception: ', '').trim());
    }
  }
}
