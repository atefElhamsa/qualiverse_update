import 'package:dio/dio.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class LoginServices {
  final Dio dio = ApiClient.dio;

  Future<LoginModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await dio.post(
        EndPoints.login,
        data: {"email": email, "password": password},
      );

      final data = response.data;

      if (data['isSuccess'] == false) {
        throw Exception(data['message'] ?? 'Login failed');
      }

      return LoginModel.fromJson(data);
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
