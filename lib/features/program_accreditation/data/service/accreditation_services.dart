import 'package:dio/dio.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class AccreditationServices {
  static final Dio dio = ApiClient.dio;

  static Future<List<AccreditationModel>> getAccreditations({
    required int academicYearId,
    int? departmentId,
  }) async {
    try {
      final response = await dio.get(
        EndPoints.accreditations(
          academicYearId: academicYearId,
          departmentId: departmentId,
        ),
      );

      final Map<String, dynamic> body = response.data;

      if (body['isSuccess'] != true) {
        throw Exception('Failed to load accreditations');
      }

      final List list = body['data'] ?? [];

      return list.map((e) => AccreditationModel.fromJson(e)).toList();
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
