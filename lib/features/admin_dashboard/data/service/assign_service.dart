import 'package:dio/dio.dart';

import '../../../../routing/all_routes_imports.dart';

class AssignService {
  static final Dio dio = ApiClient.dio;

  static Future<String> assignIndicator({
    required int indicatorId,
    required String doctorId,
    required String deadline,
  }) async {
    try {
      final response = await dio.post(
        EndPoints.assignIndicator,
        data: {
          "indicatorId": indicatorId,
          "doctorId": doctorId,
          "deadline": deadline,
        },
      );
      var data = response.data;
      final result = AssignModel.fromJson(data);
      if (!result.isSuccess) {
        throw Exception(result.error?.description ?? "Something went wrong");
      }
      return result.data ?? "Assigned successfully";
    } on DioException catch (e) {
      if (e.response?.data != null) {
        final result = AssignModel.fromJson(e.response!.data);

        throw Exception(result.error?.description ?? "Server error");
      }

      throw Exception("No Internet Connection");
    } catch (e) {
      throw Exception(e.toString().replaceFirst("Exception: ", "").trim());
    }
  }

  static Future<String> removeAssignIndicator({
    required int indicatorId,
  }) async {
    try {
      final response = await dio.delete(
        EndPoints.removeAssignIndicator(indicatorId: indicatorId),
      );
      var data = response.data;
      final result = AssignModel.fromJson(data);
      if (!result.isSuccess) {
        throw Exception(result.error?.description ?? "Something went wrong");
      }
      return result.data ?? "Removed Assigned successfully";
    } on DioException catch (e) {
      if (e.response?.data != null) {
        final result = AssignModel.fromJson(e.response!.data);

        throw Exception(result.error?.description ?? "Server error");
      }

      throw Exception("No Internet Connection");
    } catch (e) {
      throw Exception(e.toString().replaceFirst("Exception: ", "").trim());
    }
  }

  static Future<String> assignCourse({
    required int courseId,
    required String doctorId,
  }) async {
    try {
      final response = await dio.post(
        EndPoints.assignCourse,
        data: {"courseId": courseId, "doctorId": doctorId},
      );
      var data = response.data;
      final result = AssignModel.fromJson(data);
      if (!result.isSuccess) {
        throw Exception(result.error?.description ?? "Something went wrong");
      }
      return result.data ?? "Assigned successfully";
    } on DioException catch (e) {
      if (e.response?.data != null) {
        final result = AssignModel.fromJson(e.response!.data);

        throw Exception(result.error?.description ?? "Server error");
      }

      throw Exception("No Internet Connection");
    } catch (e) {
      throw Exception(e.toString().replaceFirst("Exception: ", "").trim());
    }
  }

  static Future<String> removeAssignCourse({required int courseId}) async {
    try {
      final response = await dio.delete(
        EndPoints.removeAssignCourse(courseId: courseId),
      );
      var data = response.data;
      final result = AssignModel.fromJson(data);
      if (!result.isSuccess) {
        throw Exception(result.error?.description ?? "Something went wrong");
      }
      return result.data ?? "Removed Assigned successfully";
    } on DioException catch (e) {
      if (e.response?.data != null) {
        final result = AssignModel.fromJson(e.response!.data);

        throw Exception(result.error?.description ?? "Server error");
      }

      throw Exception("No Internet Connection");
    } catch (e) {
      throw Exception(e.toString().replaceFirst("Exception: ", "").trim());
    }
  }
}
