import 'package:dio/dio.dart';
import 'package:qualiverse/features/admin_dashboard/data/model/role_model.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class RoleService {
  static final Dio dio = ApiClient.dio;

  static Future<RoleResponseModel> getRoles() async {
    try {
      final Response response = await dio.get(EndPoints.roles);
      final Map<String, dynamic> data = response.data;
      if (data['isSuccess'] != true) {
        throw Exception('Failed to load roles');
      }
      return RoleResponseModel.fromJson(data);
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw Exception('Unauthorized');
      }
      throw Exception(
        e.response?.data?['error']?['description'] ??
            e.response?.data?['message'] ??
            'Server Error',
      );
    } catch (e) {
      throw Exception(e.toString().replaceFirst('Exception: ', '').trim());
    }
  }

  static Future<String> getUserRole(String userId) async {
    try {
      final Response response = await dio.get(EndPoints.userRole(userId: userId));
      if (response.data['isSuccess'] == true) {
        return response.data['data']['role'];
      }
      throw Exception('Failed to get user role');
    } catch (e) {
      throw Exception('Error fetching user role');
    }
  }

  static Future<bool> updateUserRole({
    required String userId,
    required String roleId,
  }) async {
    try {
      final Response response = await dio.put(
        EndPoints.userRole(userId: userId),
        data: {'roleId': roleId},
      );
      if (response.data['isSuccess'] == true) {
        return true;
      }
      throw Exception(response.data['message'] ?? 'Failed to update user role');
    } on DioException catch (e) {
      throw Exception(
        e.response?.data?['error']?['description'] ??
            e.response?.data?['message'] ??
            'Server Error',
      );
    } catch (e) {
      throw Exception(e.toString().replaceFirst('Exception: ', '').trim());
    }
  }
}
