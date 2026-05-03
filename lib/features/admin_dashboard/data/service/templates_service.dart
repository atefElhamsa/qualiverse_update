import 'package:dio/dio.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class TemplatesService {
  static final Dio dio = ApiClient.dio;

  static Future<List<TemplateModel>> getTemplates() async {
    try {
      final response = await dio.get(EndPoints.templates);
      final Map<String, dynamic> body = response.data;
      if (body['isSuccess'] != true) {
        throw Exception('Failed to load templates');
      }
      final List list = body['data'] ?? [];
      return list.map((e) => TemplateModel.fromJson(e)).toList();
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

  static Future<String> createCourseFromTemplate({
    required int templateId,
    required int yearId,
    int? departmentId,
    required int levelId,
    required int termId,
  }) async {
    try {
      final response = await dio.post(
        EndPoints.courseFromTemplate,
        data: {
          "courseTemplateId": templateId,
          "departmentId": departmentId,
          "levelId": levelId,
          "termId": termId,
          "academicYearId": yearId,
        },
      );
      final Map<String, dynamic> body = response.data;
      if (body['isSuccess'] != true) {
        throw Exception('Failed to create course');
      }
      return body['data'];
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

  static Future<String> createNewCourse({
    required String nameAr,
    required String nameEn,
    required String code,
    int? departmentId,
    required int levelId,
    required int termId,
    required int yearId,
  }) async {
    try {
      final response = await dio.post(
        EndPoints.newCourse,
        data: {
          "names": [
            {"languageCode": "ar", "name": nameAr},
            {"languageCode": "en", "name": nameEn},
          ],
          "code": code,
          "departmentId": departmentId,
          "levelId": levelId,
          "termId": termId,
          "academicYearId": yearId,
        },
      );
      final Map<String, dynamic> body = response.data;
      if (body['isSuccess'] != true) {
        throw Exception(body['error'] ?? 'Failed to create course');
      }
      return body['data'];
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
