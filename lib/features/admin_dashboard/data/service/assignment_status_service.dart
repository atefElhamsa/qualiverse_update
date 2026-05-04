import 'package:dio/dio.dart';
import 'package:qualiverse/features/admin_dashboard/data/model/assignment_state_model.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class AssignmentStatusService {
  static final Dio dio = ApiClient.dio;

  static Future<AssignmentStatusResponseModel> getAssignmentStatuses() async {
    try {
      final response = await dio.get(EndPoints.assignmentsStatus);

      return AssignmentStatusResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw Exception('Unauthorized');
      }

      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.connectionTimeout) {
        throw Exception('No Internet Connection');
      }

      throw Exception(
        e.response?.data?['message'] ??
            e.response?.data?['error'] ??
            'Server Error',
      );
    } catch (e) {
      throw Exception(e.toString().replaceFirst('Exception: ', '').trim());
    }
  }
}
