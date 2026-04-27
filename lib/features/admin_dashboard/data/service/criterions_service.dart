import 'package:dio/dio.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';
import '../model/criterion_template_model.dart';

class CriterionsService {
  static final Dio dio = ApiClient.dio;

  static Future<List<CriterionItemModel>> getCriterions({
    required int academicYearId,
    int? accreditationTypeId,
    int? departmentId,
  }) async {
    try {
      final response = await dio.get(
        EndPoints.getAllCriterions(
          academicYearId: academicYearId,
          accreditationTypeId: accreditationTypeId,
          departmentId: departmentId,
        ),
      );

      final Map<String, dynamic> body = response.data;

      if (body['isSuccess'] != true) {
        throw Exception('Failed to load criterions');
      }

      final List list = body['data'] ?? [];

      return list.map((e) => CriterionItemModel.fromJson(e)).toList();
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw Exception('Unauthorized');
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

  static Future<List<CriterionTemplateModel>> getTemplateCriteria({
    required int accreditationTypeId,
  }) async {
    try {
      final response = await dio.get(
        EndPoints.getTemplateCriteria(accreditationTypeId: accreditationTypeId),
      );

      final Map<String, dynamic> body = response.data;

      if (body['isSuccess'] != true) {
        throw Exception('Failed to load template criteria');
      }

      final List list = body['data'] ?? [];

      return list.map((e) => CriterionTemplateModel.fromJson(e)).toList();
    } on DioException catch (e) {
      throw Exception(
        e.response?.data?['message'] ??
            e.response?.data?['error'] ??
            'Server Error',
      );
    } catch (e) {
      throw Exception(e.toString().replaceFirst('Exception: ', '').trim());
    }
  }

  static Future<String> createCriterionFromExistingTemplate({
    required int criterionTemplateId,
    required int accreditationTypeId,
    required int departmentId,
    required int academicYearId,
  }) async {
    try {
      final response = await dio.post(
        EndPoints.newCriterionFromExistingTemplate,
        data: {
          "criterionTemplateId": criterionTemplateId,
          "accreditationTypeId": accreditationTypeId,
          "departmentId": departmentId,
          "academicYearId": academicYearId,
        },
      );

      final Map<String, dynamic> body = response.data;

      if (body['isSuccess'] != true) {
        throw Exception('Failed to create criterion');
      }
      return body['data'] ?? '';
    } on DioException catch (e) {
      throw Exception(
        e.response?.data?['message'] ??
            e.response?.data?['error'] ??
            'Server Error',
      );
    } catch (e) {
      throw Exception(e.toString().replaceFirst('Exception: ', '').trim());
    }
  }

  static Future<String> createNewCriterion({
    required String nameAr,
    required String nameEn,
    required int accreditationTypeId,
    required int departmentId,
    required int academicYearId,
  }) async {
    try {
      final response = await dio.post(
        EndPoints.newCriterion,
        data: {
          "accreditationTypeId": accreditationTypeId,
          "departmentId": departmentId,
          "academicYearId": academicYearId,
          "translations": [
            {"languageCode": "ar", "name": nameAr},
            {"languageCode": "en", "name": nameEn},
          ],
        },
      );

      final Map<String, dynamic> body = response.data;

      if (body['isSuccess'] != true) {
        throw Exception('Failed to create criterion');
      }
      return body['data'] ?? '';
    } on DioException catch (e) {
      throw Exception(
        e.response?.data?['message'] ??
            e.response?.data?['error'] ??
            'Server Error',
      );
    } catch (e) {
      throw Exception(e.toString().replaceFirst('Exception: ', '').trim());
    }
  }

  static Future<String> toggleCriterionStatus({
    required int criterionId,
  }) async {
    try {
      final response = await dio.put(
        EndPoints.toggleCriterionStatus(criterionId: criterionId),
      );

      final Map<String, dynamic> body = response.data;

      if (body['isSuccess'] != true) {
        throw Exception('Failed to toggle status');
      }
      return body['data'];
    } on DioException catch (e) {
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
