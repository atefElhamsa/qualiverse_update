import 'package:dio/dio.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class CourseFolderService {
  static final Dio dio = ApiClient.dio;

  static Future<List<CourseFolderModel>> getCourseFolders({
    required int courseId,
  }) async {
    try {
      final response = await dio.get(
        EndPoints.getCourseFolders(courseId: courseId),
      );

      final Map<String, dynamic> body = response.data;
      if (body['isSuccess'] != true) {
        throw Exception('Failed to load course folders');
      }

      final List list = body['data'] ?? [];

      return list.map((e) => CourseFolderModel.fromJson(e)).toList();
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
}
