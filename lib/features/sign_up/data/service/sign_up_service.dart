import 'package:dio/dio.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class SignUpServices {
  final Dio dio = ApiClient.dio;

  Future<String> signUp({
    required String firstName,
    required String lastName,
    required String userName,
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
          "userName": userName,
          "email": email,
          "password": password,
          "confirmPassword": confirmPassword,
        },
      );

      var data = response.data;
      print(data);

      final result = SignUpModel.fromJson(data);

      if (!result.isSuccess) {
        throw Exception(result.error?.description ?? "Something went wrong");
      }

      return result.data ?? "Registered successfully";
    } on DioException catch (e) {
      if (e.response?.data != null) {
        final result = SignUpModel.fromJson(e.response!.data);

        throw Exception(result.error?.description ?? "Server error");
      }

      throw Exception("No Internet Connection");
    } catch (e) {
      throw Exception(e.toString().replaceFirst("Exception: ", "").trim());
    }
  }
}
