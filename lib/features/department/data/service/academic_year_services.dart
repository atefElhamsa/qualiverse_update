import 'package:dio/dio.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class AcademicYearServices {
  static final Dio dio = ApiClient.dio;

  static Future<List<AcademicYearModel>> getAcademicYears() async {
    try {
      final response = await dio.get(EndPoints.academicYears);

      final data = response.data;

      final List list = data is List ? data : data['data'];

      return list.map((e) => AcademicYearModel.fromJson(e)).toList();
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
