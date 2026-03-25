import 'package:dio/dio.dart';

import '../../../../routing/all_routes_imports.dart';

class FileService {
  static final Dio dio = ApiClient.dio;

  static Future<List<FileModel>> getFolderFiles({required int folderId}) async {
    try {
      final response = await dio.get(
        EndPoints.getFolderFiles(folderId: folderId),
      );
      final Map<String, dynamic> body = response.data;
      print(body);
      if (body['isSuccess'] != true) {
        throw Exception('Failed to load files');
      }
      final List list = body['data'] ?? [];
      return list.map((e) => FileModel.fromJson(e)).toList();
    } on DioException catch (e) {
      // Unauthorized
      if (e.response?.statusCode == 401) {
        throw Exception('Unauthorized');
      }

      // Not Found
      if (e.response?.statusCode == 404) {
        throw Exception('Resource was not found');
      }

      // No Internet
      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.connectionTimeout) {
        throw Exception('No Internet Connection');
      }

      // Server error
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
