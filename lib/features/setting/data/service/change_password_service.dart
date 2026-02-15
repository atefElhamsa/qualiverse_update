import 'package:dio/dio.dart';

import '../../../../core/all_core_imports/all_core_imports.dart';
import '../model/change_password_model.dart';

class ChangePasswordService {
  final Dio dio = ApiClient.dio;

  Future<String> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmNewPassword,
  }) async {
    try {
      final response = await dio.put(
        EndPoints.changePassword,
        data: {
          "currentPassword": currentPassword,
          "newPassword": newPassword,
          "confirmNewPassword": confirmNewPassword,
        },
      );

      final data = response.data;

      if (data is! Map<String, dynamic>) {
        throw Exception("Invalid server response");
      }

      final result = ChangePasswordModel.fromJson(data);

      if (!result.isSuccess) {
        throw Exception(result.error?.description ?? "Change password failed");
      }

      return result.data ?? "Password changed successfully";
    } on DioException catch (e) {
      if (e.response != null) {
        final statusCode = e.response!.statusCode;

        if (statusCode == 405) {
          throw Exception("Method not allowed (Check HTTP method)");
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
