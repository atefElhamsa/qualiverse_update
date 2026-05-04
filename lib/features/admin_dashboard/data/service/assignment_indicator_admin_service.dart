import 'package:dio/dio.dart';
import 'package:qualiverse/features/admin_dashboard/data/model/approve_reject_assignment_model.dart';
import 'package:qualiverse/features/admin_dashboard/data/model/assignment_indicator_admin_model.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class AssignmentIndicatorAdminService {
  static final Dio dio = ApiClient.dio;

  static Future<AssignmentIndicatorAdminResponseModel>
  getAssignmentIndicatorsAdmin({
    required int academicYearId,
    String? doctorId,
    int? status,
  }) async {
    try {
      final response = await dio.get(
        EndPoints.getAssignmentInidicatorAdmin(
          academicYearId: academicYearId,
          doctorId: doctorId,
          status: status,
        ),
      );

      return AssignmentIndicatorAdminResponseModel.fromJson(response.data);
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

  static Future<ApproveRejectAssignmentResponseModel>
  approveAssignmentIndicator({required int indicatorId}) async {
    try {
      final response = await dio.put(
        EndPoints.approveAssignmentIndicator(indicatorId: indicatorId),
      );

      return ApproveRejectAssignmentResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw Exception('Unauthorized');
      }

      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.connectionTimeout) {
        throw Exception('No Internet Connection');
      }

      final errorData = e.response?.data?['error'];
      final errorMessage =
          (errorData is Map && errorData.containsKey('description'))
          ? errorData['description']
          : (e.response?.data?['message'] ?? 'Server Error');

      throw Exception(errorMessage);
    } catch (e) {
      throw Exception(e.toString().replaceFirst('Exception: ', '').trim());
    }
  }

  static Future<ApproveRejectAssignmentResponseModel>
  rejectAssignmentIndicator({required int indicatorId}) async {
    try {
      final response = await dio.put(
        EndPoints.rejectAssignmentIndicator(indicatorId: indicatorId),
      );

      return ApproveRejectAssignmentResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw Exception('Unauthorized');
      }

      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.connectionTimeout) {
        throw Exception('No Internet Connection');
      }

      final errorData = e.response?.data?['error'];
      final errorMessage =
          (errorData is Map && errorData.containsKey('description'))
          ? errorData['description']
          : (e.response?.data?['message'] ?? 'Server Error');

      throw Exception(errorMessage);
    } catch (e) {
      throw Exception(e.toString().replaceFirst('Exception: ', '').trim());
    }
  }
}
