import 'package:dio/dio.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

import '../models/get_file_data_model.dart';

class GetFileDataService {
  static final Dio dio = ApiClient.dio;

  static Future<GetFileDataResponseModel> getFileData({
    required int courseId,
    required int academicYearId,
    required int termId,
    required int levelId,
    int? departmentId,
  }) async {
    try {
      final response = await dio.get(
        EndPoints.getFileData(
          courseId: courseId,
          academicYearId: academicYearId,
          termId: termId,
          levelId: levelId,
          departmentId: departmentId,
        ),
      );
      final Map<String, dynamic> body = response.data;

      final result = GetFileDataResponseModel.fromJson(body);
      if (!result.isSuccess) {
        throw Exception(
          result.error?.description ?? "Failed to load file data",
        );
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
}
