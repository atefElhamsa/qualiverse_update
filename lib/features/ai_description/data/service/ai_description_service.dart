import 'dart:io';
import 'package:dio/dio.dart';

import 'package:qualiverse/routing/all_routes_imports.dart';

class AiDescriptionService {
  static final Dio dio = ApiClient.dio;

  static Future<AiStartGenerationModel> startGeneration({
    required int courseId,
  }) async {
    try {
      final response = await dio.post(
        EndPoints.startGeneration,
        data: {'courseId': courseId},
      );

      final Map<String, dynamic> body = response.data;
      final result = AiStartGenerationModel.fromJson(body);
      if (!result.isSuccess) {
        throw Exception(result.error?.description ?? 'Start Generation Failed');
      }
      return result;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw Exception('Unauthorized');
      }

      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.connectionTimeout) {
        throw Exception('No Internet Connection');
      }

      var errorData = e.response?.data?['error'];
      String errorMessage = 'Server Error';

      if (errorData is Map) {
        errorMessage =
            errorData['description'] ??
            errorData['message'] ??
            errorData.toString();
      } else if (errorData is String) {
        errorMessage = errorData;
      } else if (e.response?.data?['message'] != null) {
        errorMessage = e.response?.data?['message'];
      }

      throw Exception(errorMessage);
    } catch (e) {
      throw Exception(e.toString().replaceFirst('Exception: ', '').trim());
    }
  }

  static Future<AiStartGenerationModel> uploadFiles({
    required String generationId,
    required File programFile,
    required File templateFile,
  }) async {
    final formData = FormData.fromMap({
      'Id': generationId,
      'Program': await MultipartFile.fromFile(
        programFile.path,
        filename: programFile.path.split('/').last,
      ),
      'Template': await MultipartFile.fromFile(
        templateFile.path,
        filename: templateFile.path.split('/').last,
      ),
    });

    try {
      final response = await dio.post(
        EndPoints.uploadFiles,
        data: formData,
        options: Options(contentType: 'multipart/form-data'),
      );

      final dynamic body = response.data;
      final result = AiStartGenerationModel.fromJson(body);
      if (!result.isSuccess) {
        throw Exception(result.error?.description ?? 'Upload Failed');
      }
      return result;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw Exception('Unauthorized');
      }

      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.connectionTimeout) {
        throw Exception('No Internet Connection');
      }

      var errorData = e.response?.data?['error'];
      String errorMessage = 'Server Error';

      if (errorData is Map) {
        errorMessage =
            errorData['description'] ??
            errorData['message'] ??
            errorData.toString();
      } else if (errorData is String) {
        errorMessage = errorData;
      } else if (e.response?.data?['message'] != null) {
        errorMessage = e.response?.data?['message'];
      }

      throw Exception(errorMessage);
    } catch (e) {
      throw Exception(e.toString().replaceFirst('Exception: ', '').trim());
    }
  }

  static Future<AiStartGenerationModel> confirmFiles({
    required String generationId,
  }) async {
    try {
      final response = await dio.post(EndPoints.confirmFiles(generationId));

      final dynamic body = response.data;
      final result = AiStartGenerationModel.fromJson(body);
      if (!result.isSuccess) {
        throw Exception(result.error?.description ?? 'Confirmation Failed');
      }
      return result;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw Exception('Unauthorized');
      }

      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.connectionTimeout) {
        throw Exception('No Internet Connection');
      }

      var errorData = e.response?.data?['error'];
      String errorMessage = 'Server Error';

      if (errorData is Map) {
        errorMessage =
            errorData['description'] ??
            errorData['message'] ??
            errorData.toString();
      } else if (errorData is String) {
        errorMessage = errorData;
      } else if (e.response?.data?['message'] != null) {
        errorMessage = e.response?.data?['message'];
      }

      throw Exception(errorMessage);
    } catch (e) {
      throw Exception(e.toString().replaceFirst('Exception: ', '').trim());
    }
  }

  static Future<AiStartGenerationModel> submitCourse({
    required String generationId,
    required String courseName,
    required String courseSchedule,
  }) async {
    try {
      final response = await dio.post(
        EndPoints.submitCourse(generationId),
        data: {'course_name': courseName, 'course_schedule': courseSchedule},
      );

      final dynamic body = response.data;
      final result = AiStartGenerationModel.fromJson(body);
      if (!result.isSuccess) {
        throw Exception(result.error?.description ?? 'Submission Failed');
      }
      return result;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw Exception('Unauthorized');
      }

      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.connectionTimeout) {
        throw Exception('No Internet Connection');
      }

      var errorData = e.response?.data?['error'];
      String errorMessage = 'Server Error';

      if (errorData is Map) {
        errorMessage =
            errorData['description'] ??
            errorData['message'] ??
            errorData.toString();
      } else if (errorData is String) {
        errorMessage = errorData;
      } else if (e.response?.data?['message'] != null) {
        errorMessage = e.response?.data?['message'];
      }

      throw Exception(errorMessage);
    } catch (e) {
      throw Exception(e.toString().replaceFirst('Exception: ', '').trim());
    }
  }

  static Future<AiGenerationStatusModel> checkGenerationStatus({
    required String generationId,
  }) async {
    try {
      final response = await dio.get(EndPoints.generationStatus(generationId));
      final Map<String, dynamic> body = response.data;
      final result = AiGenerationStatusModel.fromJson(body);
      if (!result.isSuccess) {
        throw Exception(result.error?.description ?? 'Failed to get status');
      }
      return result;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) throw Exception('Unauthorized');
      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.connectionTimeout) {
        throw Exception('No Internet Connection');
      }

      var errorData = e.response?.data?['error'];
      String errorMessage = 'Server Error';

      if (errorData is Map) {
        errorMessage =
            errorData['description'] ??
            errorData['message'] ??
            errorData.toString();
      } else if (errorData is String) {
        errorMessage = errorData;
      } else if (e.response?.data?['message'] != null) {
        errorMessage = e.response?.data?['message'];
      }

      throw Exception(errorMessage);
    } catch (e) {
      throw Exception(e.toString().replaceFirst('Exception: ', '').trim());
    }
  }

  static Future<AiStartGenerationModel> submitDetails({
    required String generationId,
    required Map<String, dynamic> data,
  }) async {
    try {
      final response = await dio.post(
        EndPoints.submitDetails(generationId),
        data: data,
      );

      final dynamic body = response.data;
      final result = AiStartGenerationModel.fromJson(body);
      if (!result.isSuccess) {
        throw Exception(result.error?.description ?? 'Submission Failed');
      }
      return result;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) throw Exception('Unauthorized');
      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.connectionTimeout) {
        throw Exception('No Internet Connection');
      }

      var errorData = e.response?.data?['error'];
      String errorMessage = 'Server Error';

      if (errorData is Map) {
        errorMessage =
            errorData['description'] ??
            errorData['message'] ??
            errorData.toString();
      } else if (errorData is String) {
        errorMessage = errorData;
      } else if (e.response?.data?['message'] != null) {
        errorMessage = e.response?.data?['message'];
      }

      throw Exception(errorMessage);
    } catch (e) {
      throw Exception(e.toString().replaceFirst('Exception: ', '').trim());
    }
  }

  static Future<AiDownloadFileModel> downloadFiles({
    required String generationId,
    required int fileType,
  }) async {
    try {
      final response = await dio.get(
        EndPoints.downloadFiles(generationId, fileType),
      );
      final Map<String, dynamic> body = response.data;
      final result = AiDownloadFileModel.fromJson(body);
      if (!result.isSuccess) {
        throw Exception(result.error?.description ?? 'Download Failed');
      }
      return result;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) throw Exception('Unauthorized');
      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.connectionTimeout) {
        throw Exception('No Internet Connection');
      }

      var errorData = e.response?.data?['error'];
      String errorMessage = 'Server Error';

      if (errorData is Map) {
        errorMessage =
            errorData['description'] ??
            errorData['message'] ??
            errorData.toString();
      } else if (errorData is String) {
        errorMessage = errorData;
      } else if (e.response?.data?['message'] != null) {
        errorMessage = e.response?.data?['message'];
      }

      throw Exception(errorMessage);
    } catch (e) {
      throw Exception(e.toString().replaceFirst('Exception: ', '').trim());
    }
  }

  static Future<AiGenericResponseModel> uploadCustomDescription({
    required String generationId,
    required File docxFile,
    required File pdfFile,
  }) async {
    final formData = FormData.fromMap({
      'docxFile': await MultipartFile.fromFile(
        docxFile.path,
        filename: docxFile.path.split('/').last,
      ),
      'pdfFile': await MultipartFile.fromFile(
        pdfFile.path,
        filename: pdfFile.path.split('/').last,
      ),
    });

    try {
      final response = await dio.post(
        EndPoints.uploadCustomDescription(generationId),
        data: formData,
        options: Options(contentType: 'multipart/form-data'),
      );
      final Map<String, dynamic> body = response.data;
      final result = AiGenericResponseModel.fromJson(body);
      if (!result.isSuccess) {
        throw Exception(result.error?.description ?? 'Upload Failed');
      }
      return result;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) throw Exception('Unauthorized');
      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.connectionTimeout) {
        throw Exception('No Internet Connection');
      }

      var errorData = e.response?.data?['error'];
      String errorMessage = 'Server Error';

      if (errorData is Map) {
        errorMessage =
            errorData['description'] ??
            errorData['message'] ??
            errorData.toString();
      } else if (errorData is String) {
        errorMessage = errorData;
      } else if (e.response?.data?['message'] != null) {
        errorMessage = e.response?.data?['message'];
      }

      throw Exception(errorMessage);
    } catch (e) {
      throw Exception(e.toString().replaceFirst('Exception: ', '').trim());
    }
  }

  static Future<AiGenericResponseModel> confirmGeneration({
    required String generationId,
    required String docxUrl,
    required String pdfUrl,
  }) async {
    try {
      final response = await dio.post(
        EndPoints.confirmGeneration(generationId),
        data: {'docxUrl': docxUrl, 'pdfUrl': pdfUrl},
      );
      final dynamic body = response.data;
      final result = AiGenericResponseModel.fromJson(body);
      if (!result.isSuccess) {
        throw Exception(result.error?.description ?? 'Confirmation Failed');
      }
      return result;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) throw Exception('Unauthorized');
      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.connectionTimeout) {
        throw Exception('No Internet Connection');
      }

      var errorData = e.response?.data?['error'];
      String errorMessage = 'Server Error';

      if (errorData is Map) {
        errorMessage =
            errorData['description'] ??
            errorData['message'] ??
            errorData.toString();
      } else if (errorData is String) {
        errorMessage = errorData;
      } else if (e.response?.data?['message'] != null) {
        errorMessage = e.response?.data?['message'];
      }

      throw Exception(errorMessage);
    } catch (e) {
      throw Exception(e.toString().replaceFirst('Exception: ', '').trim());
    }
  }

  static Future<AiGenericResponseModel> endGeneration({
    required String generationId,
  }) async {
    try {
      final response = await dio.post(
        EndPoints.endGeneration(generationId),
      );
      final dynamic body = response.data;
      final result = AiGenericResponseModel.fromJson(body);
      if (!result.isSuccess) {
        throw Exception(result.error?.description ?? 'End Generation Failed');
      }
      return result;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) throw Exception('Unauthorized');
      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.connectionTimeout) {
        throw Exception('No Internet Connection');
      }

      var errorData = e.response?.data?['error'];
      String errorMessage = 'Server Error';

      if (errorData is Map) {
        errorMessage =
            errorData['description'] ??
            errorData['message'] ??
            errorData.toString();
      } else if (errorData is String) {
        errorMessage = errorData;
      } else if (e.response?.data?['message'] != null) {
        errorMessage = e.response?.data?['message'];
      }

      throw Exception(errorMessage);
    } catch (e) {
      throw Exception(e.toString().replaceFirst('Exception: ', '').trim());
    }
  }

  static Future<List<AiCourseFileTypeModel>> getCourseFileTypes() async {
    try {
      final response = await dio.get(EndPoints.courseFileTypeOptions);
      final List<dynamic> body = response.data;
      return body.map((json) => AiCourseFileTypeModel.fromJson(json)).toList();
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) throw Exception('Unauthorized');
      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.connectionTimeout) {
        throw Exception('No Internet Connection');
      }

      var errorData = e.response?.data?['error'];
      String errorMessage = 'Server Error';

      if (errorData is Map) {
        errorMessage =
            errorData['description'] ??
            errorData['message'] ??
            errorData.toString();
      } else if (errorData is String) {
        errorMessage = errorData;
      } else if (e.response?.data?['message'] != null) {
        errorMessage = e.response?.data?['message'];
      }

      throw Exception(errorMessage);
    } catch (e) {
      throw Exception(e.toString().replaceFirst('Exception: ', '').trim());
    }
  }
}
