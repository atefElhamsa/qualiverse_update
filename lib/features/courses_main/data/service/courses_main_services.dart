import 'package:dio/dio.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class CoursesMainServices {
  static final Dio dio = ApiClient.dio;

  static Future<List<LevelModel>> getLevels() async {
    try {
      final response = await dio.get(EndPoints.levels);

      final Map<String, dynamic> body = response.data;

      if (body['isSuccess'] != true) {
        throw Exception('Failed to load levels');
      }

      final List list = body['data'] ?? [];

      return list.map((e) => LevelModel.fromJson(e)).toList();
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
