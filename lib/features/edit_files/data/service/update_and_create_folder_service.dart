import 'package:dio/dio.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class UpdateAndCreateFolderService {
  static final Dio dio = ApiClient.dio;

  static Future<String> updateFolder({
    required int folderId,
    required String name,
  }) async {
    try {
      final response = await dio.put(
        EndPoints.updateAndCreateCourseFolder,
        data: {"folderId": folderId, "name": name},
      );
      var data = response.data;

      final result = UpdateAndCreateFolderModel.fromJson(data);
      if (!result.isSuccess) {
        throw Exception(result.error?.description ?? "Something went wrong");
      }
      return result.data ?? "Please try again later";
    } on DioException catch (e) {
      if (e.response?.data != null) {
        final result = UpdateAndCreateFolderModel.fromJson(e.response!.data);

        throw Exception(result.error?.description ?? "Server error");
      }

      throw Exception("No Internet Connection");
    } catch (e) {
      throw Exception(e.toString().replaceFirst("Exception: ", "").trim());
    }
  }

  static Future<String> createFolder({
    required int courseId,
    required String name,
  }) async {
    try {
      final response = await dio.post(
        EndPoints.updateAndCreateCourseFolder,
        data: {"name": name, "courseId": courseId},
      );
      var data = response.data;

      final result = UpdateAndCreateFolderModel.fromJson(data);
      if (!result.isSuccess) {
        throw Exception(result.error?.description ?? "Something went wrong");
      }
      return result.data ?? "Please try again later";
    } on DioException catch (e) {
      if (e.response?.data != null) {
        final result = UpdateAndCreateFolderModel.fromJson(e.response!.data);

        throw Exception(result.error?.description ?? "Server error");
      }

      throw Exception("No Internet Connection");
    } catch (e) {
      throw Exception(e.toString().replaceFirst("Exception: ", "").trim());
    }
  }
}
