import 'package:dio/dio.dart';

import '../../../../core/all_core_imports/all_core_imports.dart';

class AccountVerificationService {
  final Dio dio = ApiClient.dio;

  Future<bool> verificationAccount({required String email}) async {
    try {
      final response = await dio.post(
        EndPoints.accountVerification,
        data: {"email": email},
      );

      final data = response.data;

      if (data['isSuccess'] == true) {
        return true;
      }

      throw Exception(data['error']?['description'] ?? "Verification failed");
    } on DioException catch (e) {
      if (e.response?.data != null) {
        final errorData = e.response!.data;

        throw Exception(errorData['error']?['description'] ?? "Server error");
      }

      throw Exception("No Internet Connection");
    }
  }
}
