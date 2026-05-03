import 'package:dio/dio.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class CyclesCoursesService {
  static final Dio dio = ApiClient.dio;

  static Future<List<CourseItemModel>> getCourses({
    required int academicYearId,
    int? departmentId,
    required int levelId,
    required int termId,
  }) async {
    try {
      final response = await dio.get(
        EndPoints.coursesByDepartment(
          academicYearId: academicYearId,
          departmentId: departmentId,
          levelId: levelId,
          termId: termId,
        ),
      );
      final Map<String, dynamic> body = response.data;
      if (body['isSuccess'] != true) {
        throw Exception('Failed to load courses');
      }
      final List list = body['data'] is List ? body['data'] : [];
      return list.map((e) => CourseItemModel.fromJson(e)).toList();
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw Exception('Unauthorized');
      }

      if (e.response?.data != null) {
        final result = AssignModel.fromJson(e.response!.data);
        throw Exception(result.error?.description ?? "Server Error");
      }

      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.connectionTimeout) {
        throw Exception('No Internet Connection');
      }

      throw Exception('Server Error');
    } catch (e) {
      throw Exception(e.toString().replaceFirst('Exception: ', '').trim());
    }
  }

  static Future<String> deleteCourse({required int courseId}) async {
    try {
      final response = await dio.delete(
        EndPoints.deleteCourse(courseId: courseId),
      );
      var data = response.data;
      final result = AssignModel.fromJson(data);
      if (!result.isSuccess) {
        throw Exception(result.error?.description ?? "Failed to delete course");
      }
      return result.data ?? 'Course deleted successfully';
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw Exception('Unauthorized');
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
