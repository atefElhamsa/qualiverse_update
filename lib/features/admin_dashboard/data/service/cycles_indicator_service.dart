import 'package:dio/dio.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class CyclesIndicatorService {
  static final Dio dio = ApiClient.dio;

  static Future<List<CycleIndicatorModel>> getCycleIndicators({
    required int yearId,
    int? departmentId,
    int? criterionId,
  }) async {
    try {
      final response = await dio.get(
        EndPoints.getCycleIndicators(
          yearId: yearId,
          departmentId: departmentId,
          criterionId: criterionId,
        ),
      );
      final Map<String, dynamic> body = response.data;
      if (body['isSuccess'] != true) {
        throw Exception('Failed to load cycle indicators');
      }
      final List list = body['data'] ?? [];
      return list.map((e) => CycleIndicatorModel.fromJson(e)).toList();
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
