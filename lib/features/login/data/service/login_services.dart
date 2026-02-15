import 'package:dio/dio.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class LoginServices {
  final Dio dio = ApiClient.dio;

  Future<LoginDataModel> login({
    required String userNameOrEmail,
    required String password,
  }) async {
    try {
      final response = await dio.post(
        EndPoints.login,
        data: {"userNameOrEmail": userNameOrEmail, "password": password},
      );

      var data = response.data;

      final result = LoginModel.fromJson(data);

      if (!result.isSuccess) {
        throw Exception(result.error?.description ?? "Login failed");
      }

      return result.data!;
    } on DioException catch (e) {
      if (e.response?.data != null) {
        final result = LoginModel.fromJson(e.response!.data);

        throw Exception(result.error?.description ?? "Server error");
      }

      throw Exception("No Internet Connection");
    } catch (e) {
      throw Exception(e.toString().replaceFirst("Exception: ", "").trim());
    }
  }
}
