import 'package:dio/dio.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class LogoutService {
  final Dio dio = ApiClient.dio;

  Future<String> logout() async {
    try {
      final response = await dio.post(
        EndPoints.revoke,
        data: {
          "token": LoginStorage.token,
          "refreshToken": LoginStorage.refreshToken,
        },
      );

      final data = response.data;

      if (data is! Map<String, dynamic>) {
        throw Exception("Invalid server response");
      }

      final result = LogoutResponse.fromJson(data);

      if (!result.isSuccess) {
        throw Exception(result.error?.description ?? "Logout failed");
      }

      return result.data ?? "Logged out successfully";
    } on DioException catch (e) {
      if (e.response != null) {
        final statusCode = e.response!.statusCode;

        if (statusCode == 401) {
          throw Exception("Session expired, please login again");
        }

        if (e.response!.data is Map<String, dynamic>) {
          throw Exception(
            e.response!.data["error"]?["description"] ?? "Server error",
          );
        }

        throw Exception("Server error ($statusCode)");
      }

      throw Exception("No Internet Connection");
    } catch (e) {
      throw Exception(e.toString().replaceFirst("Exception: ", "").trim());
    }
  }
}
