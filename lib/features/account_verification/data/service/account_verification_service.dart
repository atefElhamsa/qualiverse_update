import 'package:dio/dio.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class AccountVerificationService {
  final Dio dio = ApiClient.dio;

  Future<void> verificationAccount({required String email}) async {
    try {
      final response = await dio.post(
        EndPoints.accountVerification,
        data: {"email": email},
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        return;
      }
    } on DioException catch (e) {
      if (e.response?.data is Map<String, dynamic>) {
        throw AccountVerificationModel.fromJson(e.response!.data);
      }

      throw const AccountVerificationModel(
        type: '',
        title: 'Network Error',
        status: 0,
        errors: ['No Internet Connection'],
      );
    }
  }
}
