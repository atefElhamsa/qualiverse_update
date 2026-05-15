import 'dart:io';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:qualiverse/core/network/api_client.dart';
import 'package:qualiverse/core/utils/end_points.dart';

class FileDownloadHelper {
  static final Dio _dio = ApiClient.dio;

  static Future<String?> downloadAndOpen({
    required String filePath,
    required String fileName,
    void Function(int received, int total)? onProgress,
  }) async {
    try {
      // Build full URL
      final url = filePath.startsWith('http')
          ? filePath
          : '${EndPoints.baseUrlToOpenFile}/${filePath.startsWith('/') ? filePath.substring(1) : filePath}';

      // Get file extension
      final ext = fileName.contains('.') ? fileName.split('.').last : null;

      // Let user choose save location
      final savePath = await FilePicker.platform.saveFile(
        dialogTitle: 'اختر مكان حفظ الملف',
        fileName: fileName,
        allowedExtensions: ext != null ? [ext] : null,
        type: ext != null ? FileType.custom : FileType.any,
      );

      // User cancelled
      if (savePath == null) return null;

      // Download the file to the chosen path
      await _dio.download(
        url,
        savePath,
        onReceiveProgress: onProgress,
        deleteOnError: true,
        options: Options(
          responseType: ResponseType.bytes,
          receiveTimeout: const Duration(minutes: 5),
          headers: {'Accept': '*/*'},
        ),
      );

      // Open the saved file
      if (Platform.isWindows) {
        await Process.run('explorer', [savePath]);
      }

      return null;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        return 'Session expired, please login again';
      }
      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.connectionTimeout) {
        return 'No internet connection';
      }
      return e.message ?? 'Download failed';
    } catch (e) {
      return e.toString().replaceFirst('Exception: ', '').trim();
    }
  }
}
