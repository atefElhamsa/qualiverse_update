import 'package:dio/dio.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class TypesService {
  static final Dio dio = ApiClient.dio;

  static Future<AccreditationType> getTypes() async {
    try {
      final response = await dio.get(EndPoints.accreditationTypes);

      final Map<String, dynamic> body = response.data;

      final result = AccreditationType.fromJson(body);

      if (!result.isSuccess) {
        throw Exception(result.error?.description ?? "Failed to load types");
      }

      return result;
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
