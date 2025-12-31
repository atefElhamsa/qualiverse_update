import 'package:dio/dio.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class SignUpServices {
  final Dio dio = ApiClient.dio;

  Future<String> signUp({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      final response = await dio.post(
        EndPoints.register,
        data: {
          "firstName": firstName,
          "lastName": lastName,
          "email": email,
          "password": password,
          "confirmPassword": confirmPassword,
        },
      );

      var data = response.data;

      if (data is Map && data['isSuccess'] == false) {
        throw Exception(data['message'] ?? 'Something went wrong');
      }

      final msg = data['message'] ?? 'Registered successfully';
      return msg;
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
