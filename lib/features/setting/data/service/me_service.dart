import 'package:dio/dio.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class MeService {
  final Dio dio = ApiClient.dio;

  Future<MeModel> myInfo() async {
    try {
      final response = await dio.get(EndPoints.me);

      final data = response.data;

      final result = MeResponse.fromJson(data);

      if (!result.isSuccess) {
        throw Exception(result.error?.description ?? "Get info failed");
      }
      return result.data!;
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
