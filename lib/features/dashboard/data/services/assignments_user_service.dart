import 'package:dio/dio.dart';
import 'package:qualiverse/features/dashboard/data/models/assignments_user_model.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class AssignmentsUserService {
  static final Dio dio = ApiClient.dio;

  Future<AssignmentsUserModel> getAssignmentsUser({
    required int academicYearId,
    int? status,
  }) async {
    try {
      final response = await dio.get(
        EndPoints.getMyAssignments(
          academicYearId: academicYearId,
          status: status,
        ),
      );
      if (response.statusCode == 200) {
        final model = AssignmentsUserModel.fromJson(response.data);
        if (!model.isSuccess) {
          throw Exception(model.error?.description ?? 'Failed to load assignments');
        }
        return model;
      } else {
        throw Exception(response.data['message']);
      }
    } on DioException catch (e) {
      throw Exception(
        e.response?.data['message'] ?? 'Failed to load assignments',
      );
    } catch (e) {
      throw Exception('Failed to load assignments');
    }
  }
}
