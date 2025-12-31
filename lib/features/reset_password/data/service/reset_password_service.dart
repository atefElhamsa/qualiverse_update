import 'package:dio/dio.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class ResetPasswordService {
  final Dio dio = ApiClient.dio;

  Future<String> resetPassword({required String email}) async {
    try {
      final response = await dio.post(
        EndPoints.forgotPassword,
        data: {"email": email},
      );
      final data = response.data;
      if (data is Map) {
        final msg = data['message'] ?? 'Check your email';
        return msg;
      }
      return 'Check your email';
    } on DioException catch (e) {
      final msg =
          e.response?.data?['message'] ??
          e.response?.data?['error'] ??
          "No Internet Connection";
      throw Exception(msg);
    } catch (e) {
      throw Exception(e.toString().replaceFirst("Exception: ", "").trim());
    }
  }
}
