import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';

class UpdaterService {
  static String get _versionUrl =>
      'https://raw.githubusercontent.com/atefElhamsa/qualiverse_update/main/version.json?t=${DateTime.now().millisecondsSinceEpoch}';

  static Future<void> checkForUpdate(BuildContext context) async {
    try {
      final response = await http.get(Uri.parse(_versionUrl));
      if (response.statusCode != 200) return;

      final data = jsonDecode(response.body);
      final latestVersion = data['version'] as String;
      final downloadUrl = data['url'] as String;
      final notes = data['notes'] as String;

      final info = await PackageInfo.fromPlatform();
      final currentVersion = info.version;

      if (_isNewer(latestVersion, currentVersion)) {
        if (context.mounted) {
          await _showUpdateDialog(context, latestVersion, downloadUrl, notes);
        }
      }
    } catch (e) {
      debugPrint('Update check failed: $e');
    }
  }

  static bool _isNewer(String latest, String current) {
    try {
      final l = latest.split('.').map((e) => int.tryParse(e) ?? 0).toList();
      final c = current.split('.').map((e) => int.tryParse(e) ?? 0).toList();

      int len = l.length > c.length ? l.length : c.length;
      for (int i = 0; i < len; i++) {
        int lVal = i < l.length ? l[i] : 0;
        int cVal = i < c.length ? c[i] : 0;

        if (lVal > cVal) return true;
        if (lVal < cVal) return false;
      }
    } catch (e) {
      debugPrint('Error comparing versions: $e');
    }
    return false;
  }

  static Future<void> _showUpdateDialog(
    BuildContext context,
    String version,
    String url,
    String notes,
  ) async {
    bool isDownloading = false;
    String statusText = 'يوجد إصدار جديد متاح للتحميل';

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          return PopScope(
            canPop: false,
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              title: Row(
                children: [
                  const Icon(
                    Icons.system_update,
                    color: Colors.blueAccent,
                    size: 28,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'تحديث جديد v$version',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(statusText, style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 15),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      notes,
                      style: TextStyle(color: Colors.grey[800], fontSize: 14),
                    ),
                  ),
                  if (isDownloading) ...[
                    const SizedBox(height: 20),
                    const LinearProgressIndicator(),
                    const SizedBox(height: 10),
                    const Center(child: Text('جاري التحميل والتثبيت...')),
                  ],
                ],
              ),
              actions: [
                if (!isDownloading)
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () async {
                        setState(() {
                          isDownloading = true;
                          statusText =
                              'يرجى عدم إغلاق البرنامج حتى اكتمال التحديث';
                        });
                        try {
                          await _downloadAndInstall(url);
                        } catch (e) {
                          setState(() {
                            isDownloading = false;
                            statusText = 'فشل التحديث: تأكد من اتصال الإنترنت';
                          });
                          debugPrint('Download error: $e');
                        }
                      },
                      child: const Text(
                        'تحديث الآن',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  static Future<void> _downloadAndInstall(String url) async {
    final dir = await getTemporaryDirectory();
    final zipPath = '${dir.path}/update.zip';
    final extractPath = '${dir.path}/update_extracted';

    // 1. Download
    final response = await http.get(Uri.parse(url));
    if (response.statusCode != 200) throw Exception('Failed to download file');
    await File(zipPath).writeAsBytes(response.bodyBytes);

    // 2. Extract
    if (Platform.isWindows) {
      await Process.run('powershell', [
        '-Command',
        'Expand-Archive -Path "$zipPath" -DestinationPath "$extractPath" -Force',
      ]);

      // 3. Find EXE and Run
      final entities = await Directory(
        extractPath,
      ).list(recursive: true).toList();
      final exeFiles = entities
          .whereType<File>()
          .where((f) => f.path.endsWith('.exe'))
          .toList();

      if (exeFiles.isNotEmpty) {
        await Process.start(exeFiles.first.path, [], runInShell: true);
        exit(0);
      } else {
        throw Exception('لم يتم العثور على ملف التشغيل داخل التحديث');
      }
    }
  }
}
