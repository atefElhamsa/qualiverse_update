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

      final data = response.data;
      final List list = data is List ? data : data['data'];

      return list.map((e) => AccreditationModel.fromJson(e)).toList();
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
