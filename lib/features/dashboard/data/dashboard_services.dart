import 'package:dio/dio.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';
import 'models/dashboard_response_model.dart';

class DashboardServices {
  Future<DashboardResponseModel> getDashboard({
    int? yearId,
    int? departmentId,
    int? levelId,
    int? accreditationTypeId,
  }) async {
    try {
      final response = await ApiClient.dio.get(
        EndPoints.getDashboard(
          yearId: yearId,
          departmentId: departmentId,
          levelId: levelId,
          accreditationTypeId: accreditationTypeId,
        ),
        options: Options(
          sendTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
        ),
      );
      if (response.statusCode == 200) {
        return DashboardResponseModel.fromJson(response.data);
      } else {
        throw Exception(response.data['message'] ?? 'Failed to load dashboard');
      }
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Failed to load dashboard');
    } catch (e) {
      throw Exception('Failed to load dashboard');
    }
  }
}
