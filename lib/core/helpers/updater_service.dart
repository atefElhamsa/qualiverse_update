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
                          await _downloadAndInstall(url, (newStatus) {
                            setState(() {
                              statusText = newStatus;
                            });
                          });
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

  static Future<void> _downloadAndInstall(
      String url, Function(String) onStatusChanged) async {
    final dir = await getTemporaryDirectory();
    final zipPath = '${dir.path}/update.zip';
    final extractPath = '${dir.path}/update_extracted';

      // 1. Download
      onStatusChanged('جاري التحميل (0%)...');
      debugPrint('بدء تحميل التحديث من: $url');
      
      final client = http.Client();
      final request = http.Request('GET', Uri.parse(url));
      final response = await client.send(request);
      
      if (response.statusCode != 200) {
        client.close();
        throw Exception('Failed to download file: ${response.statusCode}');
      }

      final contentLength = response.contentLength;
      int downloaded = 0;
      final file = File(zipPath);
      final sink = file.openWrite();

      try {
        await for (var chunk in response.stream) {
          downloaded += chunk.length;
          sink.add(chunk);
          
          if (contentLength != null && contentLength > 0) {
            final percent = (downloaded / contentLength * 100).toStringAsFixed(0);
            onStatusChanged('جاري تحميل ملفات التحديث ($percent%)...');
          } else {
            // إذا لم يوفر السيرفر حجم الملف، نظهر الحجم المحمل بالميجابايت
            final mb = (downloaded / (1024 * 1024)).toStringAsFixed(1);
            onStatusChanged('جاري التحميل ($mb MB)...');
          }
        }
      } finally {
        await sink.close();
        client.close();
      }
      
      debugPrint('اكتمل التحميل بنجاح.');

      // 2. Extract
      onStatusChanged('جاري فك ضغط الملفات...');
      if (Platform.isWindows) {
        debugPrint('بدء فك الضغط...');
        // Clean old extraction if exists
        if (await Directory(extractPath).exists()) {
          await Directory(extractPath).delete(recursive: true);
        }
        await Directory(extractPath).create(recursive: true);

        // استخدام tar بدلاً من Expand-Archive لأنه أسرع بمراحل في ويندوز
        await Process.run('tar', [
          '-xf',
          zipPath,
          '-C',
          extractPath,
        ]);
        debugPrint('اكتمل فك الضغط بنجاح.');

        onStatusChanged('جاري تجهيز السكربت النهائي لإعادة التشغيل...');

      // 3. Identify paths
      final currentExePath = Platform.resolvedExecutable;
      final installDir = File(currentExePath).parent.path;

      // Find the new EXE in the extracted folder
      final entities = await Directory(
        extractPath,
      ).list(recursive: true).toList();
      final exeFiles = entities
          .whereType<File>()
          .where((f) => f.path.endsWith('.exe'))
          .toList();

      if (exeFiles.isEmpty) {
        throw Exception('لم يتم العثور على ملف التشغيل داخل التحديث');
      }

      // The extracted folder might have the files directly or in a subfolder
      // We want the folder containing the EXE and its DLLs
      final newFilesDir = exeFiles.first.parent.path;

      // 4. Create a PowerShell script to replace files after exit
      final scriptPath = '${dir.path}\\update_script.ps1';
      final logPath = '${dir.path}\\update_log.txt';
      final currentPid = pid;

      final scriptContent = '''
\$logFile = "$logPath"
"Starting update at \$(Get-Date)" | Out-File \$logFile
"Current PID: $currentPid" | Out-File \$logFile -Append
"Install Dir: $installDir" | Out-File \$logFile -Append
"New Files Dir: $newFilesDir" | Out-File \$logFile -Append

# Wait for the app to close
"Waiting for process $currentPid to exit..." | Out-File \$logFile -Append
while (Get-Process -Id $currentPid -ErrorAction SilentlyContinue) {
    Start-Sleep -Milliseconds 500
}

# Give it a bit more time to ensure all file handles are released
"Process exited. Waiting 2 seconds for file handles to release..." | Out-File \$logFile -Append
Start-Sleep -Seconds 2

# Delete old files in the installation directory
"Cleaning installation directory..." | Out-File \$logFile -Append
Get-ChildItem -Path "$installDir" -Recurse | Sort-Object -Property FullName -Descending | ForEach-Object {
    try {
        Remove-Item -Path \$_.FullName -Force -Recurse -ErrorAction Stop
        "Deleted: \$(\$_.FullName)" | Out-File \$logFile -Append
    } catch {
        "Failed to delete: \$(\$_.FullName). Error: \$(\$_.Exception.Message)" | Out-File \$logFile -Append
    }
}

# Copy new files to install directory
"Copying new files..." | Out-File \$logFile -Append
try {
    Copy-Item -Path "$newFilesDir\\*" -Destination "$installDir" -Recurse -Force -ErrorAction Stop
    "Copy successful." | Out-File \$logFile -Append
} catch {
    "Copy failed. Error: \$(\$_.Exception.Message)" | Out-File \$logFile -Append
}

# Restart the app from the original location
"Restarting app: $currentExePath" | Out-File \$logFile -Append
try {
    Start-Process "$currentExePath"
    "Restart command issued." | Out-File \$logFile -Append
} catch {
    "Failed to restart app. Error: \$(\$_.Exception.Message)" | Out-File \$logFile -Append
}

# Clean up temporary files
"Cleaning up temp files..." | Out-File \$logFile -Append
try {
    Remove-Item -Path "$zipPath" -Force -ErrorAction SilentlyContinue
    Remove-Item -Path "$extractPath" -Recurse -Force -ErrorAction SilentlyContinue
    "Cleanup finished." | Out-File \$logFile -Append
} catch {
    "Cleanup failed." | Out-File \$logFile -Append
}

"Update process completed at \$(Get-Date)" | Out-File \$logFile -Append
''';

      await File(scriptPath).writeAsString(scriptContent);

      debugPrint('Update script created at: $scriptPath');
      debugPrint('Update log will be at: $logPath');

      // 5. Run the script and exit
      await Process.start('powershell', [
        '-WindowStyle',
        'Hidden',
        '-ExecutionPolicy',
        'Bypass',
        '-File',
        scriptPath,
      ], runInShell: true);

      exit(0);
    }
  }
}
