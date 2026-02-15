import 'package:dio/dio.dart';

import '../../../../routing/all_routes_imports.dart';

class ResetPasswordService {
  final Dio dio = ApiClient.dio;

  Future<String> resetPassword({required String email}) async {
    try {
      final response = await dio.post(
        EndPoints.forgotPassword,
        data: {"email": email},
      );

      var data = response.data;

      final result = ResetPasswordModel.fromJson(data);

      if (!result.isSuccess) {
        throw Exception(result.error?.description ?? "Something went wrong");
      }

      return result.data ?? "Check your email";
    } on DioException catch (e) {
      if (e.response?.data != null) {
        final result = ResetPasswordModel.fromJson(e.response!.data);

        throw Exception(result.error?.description ?? "Server error");
      }

      throw Exception("No Internet Connection");
    } catch (e) {
      throw Exception(e.toString().replaceFirst("Exception: ", "").trim());
    }
  }
}
