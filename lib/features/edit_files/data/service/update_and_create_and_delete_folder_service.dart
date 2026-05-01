import 'package:dio/dio.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class UpdateAndCreateAndDeleteFolderService {
  static final Dio dio = ApiClient.dio;

  static Future<String> updateFolder({
    required int folderId,
    required String nameAr,
    required String nameEn,
  }) async {
    try {
      final response = await dio.put(
        EndPoints.updateAndCreateCourseFolder,
        data: {
          "folderId": folderId,
          "translations": [
            {"languageCode": "ar", "name": nameAr},
            {"languageCode": "en", "name": nameEn},
          ],
        },
      );
      var data = response.data;

      final result = UpdateAndCreateAndDeleteFolderModel.fromJson(data);
      if (!result.isSuccess) {
        throw Exception(result.error?.description ?? "Something went wrong");
      }
      return result.data ?? "Please try again later";
    } on DioException catch (e) {
      if (e.response?.data != null) {
        final result = UpdateAndCreateAndDeleteFolderModel.fromJson(
          e.response!.data,
        );

        throw Exception(result.error?.description ?? "Server error");
      }

      throw Exception("No Internet Connection");
    } catch (e) {
      throw Exception(e.toString().replaceFirst("Exception: ", "").trim());
    }
  }

  static Future<String> createFolder({
    required int courseId,
    required String nameAr,
    required String nameEn,
  }) async {
    try {
      final response = await dio.post(
        EndPoints.updateAndCreateCourseFolder,
        data: {
          "courseId": courseId,
          "translations": [
            {"languageCode": "ar", "name": nameAr},
            {"languageCode": "en", "name": nameEn},
          ],
        },
      );
      var data = response.data;

      final result = UpdateAndCreateAndDeleteFolderModel.fromJson(data);
      if (!result.isSuccess) {
        throw Exception(result.error?.description ?? "Something went wrong");
      }
      return result.data ?? "Please try again later";
    } on DioException catch (e) {
      if (e.response?.data != null) {
        final result = UpdateAndCreateAndDeleteFolderModel.fromJson(
          e.response!.data,
        );

        throw Exception(result.error?.description ?? "Server error");
      }

      throw Exception("No Internet Connection");
    } catch (e) {
      throw Exception(e.toString().replaceFirst("Exception: ", "").trim());
    }
  }

  static Future<String> deleteFolder({required int folderId}) async {
    try {
      final response = await dio.delete(
        EndPoints.deleteCourseFolder(folderId: folderId),
      );
      var data = response.data;

      final result = UpdateAndCreateAndDeleteFolderModel.fromJson(data);
      if (!result.isSuccess) {
        throw Exception(result.error?.description ?? "Something went wrong");
      }
      return result.data ?? "Please try again later";
    } on DioException catch (e) {
      if (e.response?.data != null) {
        final result = UpdateAndCreateAndDeleteFolderModel.fromJson(
          e.response!.data,
        );

        throw Exception(result.error?.description ?? "Server error");
      }

      throw Exception("No Internet Connection");
    } catch (e) {
      throw Exception(e.toString().replaceFirst("Exception: ", "").trim());
    }
  }
}
