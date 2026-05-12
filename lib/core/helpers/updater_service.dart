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
      final force = data['force'] as bool;
      final notes = data['notes'] as String;

      final info = await PackageInfo.fromPlatform();
      final currentVersion = info.version;

      debugPrint('--- Update Check ---');
      debugPrint('Current Version: $currentVersion');
      debugPrint('Latest Version: $latestVersion');

      if (_isNewer(latestVersion, currentVersion)) {
        debugPrint('New version detected! Showing dialog...');
        if (context.mounted) {
          await _showUpdateDialog(context, latestVersion, downloadUrl, force, notes);
        }
      } else {
        debugPrint('No new version found.');
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
    bool force,
    String notes,
  ) async {
    await showDialog(
      context: context,
      barrierDismissible: !force,
      builder: (_) => PopScope(
        canPop: !force,
        child: AlertDialog(
          title: Text('تحديث متاح 🚀 v$version'),
          content: Text(notes),
          actions: [
            if (!force)
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('لاحقاً'),
              ),
            ElevatedButton(
              onPressed: () => _downloadAndInstall(url),
              child: const Text('تحديث الآن'),
            ),
          ],
        ),
      ),
    );
  }

  static Future<void> _downloadAndInstall(String url) async {
    final dir = await getTemporaryDirectory();
    final zipPath = '${dir.path}/update.zip';
    final extractPath = '${dir.path}/update_extracted';

    final response = await http.get(Uri.parse(url));
    await File(zipPath).writeAsBytes(response.bodyBytes);

    await Process.run('powershell', [
      '-Command',
      'Expand-Archive -Path "$zipPath" -DestinationPath "$extractPath" -Force',
    ]);

    final exeFiles = Directory(extractPath)
        .listSync()
        .whereType<File>()
        .where((f) => f.path.endsWith('.exe'))
        .toList();

    if (exeFiles.isNotEmpty) {
      await Process.start(exeFiles.first.path, [], runInShell: true);
      exit(0);
    }
  }
}
