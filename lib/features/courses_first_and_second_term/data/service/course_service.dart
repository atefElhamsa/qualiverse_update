import 'package:dio/dio.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class CourseService {
  static final Dio dio = ApiClient.dio;

  static Future<CoursesResponseModel> getCourses({
    required int yearId,
    required int levelId,
    required int termId,
    int? departmentId,
    String? lang,
  }) async {
    try {
      final response = await dio.get(
        EndPoints.courses(
          yearId: yearId,
          levelId: levelId,
          termId: termId,
          departmentId: departmentId,
        ),
        options: lang != null ? Options(headers: {'Accept-Language': lang}) : null,
      );
      final Map<String, dynamic> body = response.data;
      final result = CoursesResponseModel.fromJson(body);
      if (!result.isSuccess) {
        throw Exception('Failed to load courses');
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
      final errorData = e.response?.data?['error'] ?? e.response?.data?['message'];
      if (errorData is Map && errorData.containsKey('description')) {
        throw Exception(errorData['description']);
      }
      throw Exception(errorData?.toString() ?? 'Server Error');
    } catch (e) {
      throw Exception(e.toString().replaceFirst('Exception: ', '').trim());
    }
  }
}
