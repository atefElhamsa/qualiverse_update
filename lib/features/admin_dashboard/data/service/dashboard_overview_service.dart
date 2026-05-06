import 'package:dio/dio.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class DashboardOverviewService {
  static final Dio dio = ApiClient.dio;

  static Future<DashboardTotalsResponseModel> getDashboardTotals({
    required int yearId,
  }) async {
    try {
      final response = await dio.get(
        EndPoints.getDashboardTotals(yearId: yearId),
      );
      var data = response.data;
      final result = DashboardTotalsResponseModel.fromJson(data);
      if (!result.isSuccess) {
        throw Exception(result.error?.description ?? "Something went wrong");
      }
      return result;
    } on DioException catch (e) {
      if (e.response?.data != null) {
        final result = DashboardTotalsResponseModel.fromJson(e.response!.data);

        throw Exception(result.error?.description ?? "Server error");
      }

      throw Exception("No Internet Connection");
    } catch (e) {
      throw Exception(e.toString().replaceFirst("Exception: ", "").trim());
    }
  }

  static Future<DepartmentProgressResponseModel> getDepartmentProgress({
    required int yearId,
  }) async {
    try {
      final response = await dio.get(
        EndPoints.getDepartmentProgress(yearId: yearId),
      );
      final result = DepartmentProgressResponseModel.fromJson(response.data);
      if (!result.isSuccess) {
        throw Exception(result.error?.description ?? "Something went wrong");
      }
      return result;
    } on DioException catch (e) {
      if (e.response?.data != null) {
        final result = DepartmentProgressResponseModel.fromJson(e.response!.data);
        throw Exception(result.error?.description ?? "Server error");
      }
      throw Exception("No Internet Connection");
    } catch (e) {
      throw Exception(e.toString().replaceFirst("Exception: ", "").trim());
    }
  }

  static Future<InstitutionalProgressResponseModel> getInstitutionalProgress({
    required int yearId,
  }) async {
    try {
      final response = await dio.get(
        EndPoints.getInstitutionalProgress(yearId: yearId),
      );
      final result = InstitutionalProgressResponseModel.fromJson(response.data);
      if (!result.isSuccess) {
        throw Exception(result.error?.description ?? "Something went wrong");
      }
      return result;
    } on DioException catch (e) {
      if (e.response?.data != null) {
        final result = InstitutionalProgressResponseModel.fromJson(e.response!.data);
        throw Exception(result.error?.description ?? "Server error");
      }
      throw Exception("No Internet Connection");
    } catch (e) {
      throw Exception(e.toString().replaceFirst("Exception: ", "").trim());
    }
  }
}
