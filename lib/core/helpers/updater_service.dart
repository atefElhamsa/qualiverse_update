import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

class UpdaterService {
  static Map<String, String> get _headers => {
    'User-Agent': 'QualiVerse-Updater',
    'Accept': 'application/json',
  };

  static String get _versionUrl =>
      'https://raw.githubusercontent.com/atefElhamsa/qualiverse_update/main/version.json?t=${DateTime.now().millisecondsSinceEpoch}';

  static Future<void> checkForUpdate(BuildContext context) async {
    try {
      debugPrint('Checking for update at: $_versionUrl');
      final response = await http.get(
        Uri.parse(_versionUrl),
        headers: _headers,
      );
      if (response.statusCode != 200) {
        debugPrint('Update check failed with status: ${response.statusCode}');
        return;
      }

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
      // تنظيف إصدارات البرنامج من أي زيادات مثل +13 أو -beta
      String cleanLatest = latest.split('+')[0].split('-')[0];
      String cleanCurrent = current.split('+')[0].split('-')[0];

      final l = cleanLatest
          .split('.')
          .map((e) => int.tryParse(e) ?? 0)
          .toList();
      final c = cleanCurrent
          .split('.')
          .map((e) => int.tryParse(e) ?? 0)
          .toList();

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
                  Center(
                    child: Text(
                      statusText,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.blueAccent,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  if (isDownloading) ...[
                    const SizedBox(height: 20),
                    const LinearProgressIndicator(
                      backgroundColor: Colors.grey,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.blueAccent,
                      ),
                    ),
                    const SizedBox(height: 10),
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
                            statusText = 'فشل: $e';
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
    String url,
    Function(String) onStatusChanged,
  ) async {
    final currentExePath = Platform.resolvedExecutable;
    final installDir = File(currentExePath).parent.path;
    final exeName = p.basename(currentExePath);

    final tempDir = await getTemporaryDirectory();
    final zipPath = p.join(tempDir.path, 'update.zip');
    final extractPath = p.join(tempDir.path, 'update_extracted');
    final logPath = p.join(tempDir.path, 'update_log.txt');
    final scriptPath = p.join(tempDir.path, 'update_script.ps1');

    try {
      // 1. Download
      onStatusChanged('جاري تحميل التحديث...');
      debugPrint('بدء تحميل التحديث من: $url');

      // إضافة باراميتر عشوائي لتخطي الكاش الخاص بـ GitHub
      final finalUrl = url.contains('?')
          ? '$url&t=${DateTime.now().millisecondsSinceEpoch}'
          : '$url?t=${DateTime.now().millisecondsSinceEpoch}';

      final client = http.Client();
      final request = http.Request('GET', Uri.parse(finalUrl));
      request.headers.addAll(_headers);
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
            final percent = (downloaded / contentLength * 100).toStringAsFixed(
              0,
            );
            onStatusChanged('جاري التحميل ($percent%)...');
          } else {
            final mb = (downloaded / (1024 * 1024)).toStringAsFixed(1);
            onStatusChanged('جاري التحميل ($mb MB)...');
          }
        }
      } finally {
        await sink.close();
        client.close();
      }

      debugPrint('اكتمل التحميل: $zipPath');

      // 2. Create a robust PowerShell script
      // Note: We use double quotes for all paths to handle spaces in usernames
      final scriptContent =
          '''
\$logFile = "$logPath"
"--- Update started at \$(Get-Date) ---" | Out-File \$logFile
"Install Dir: $installDir" | Out-File \$logFile -Append

function Write-Log(\$msg) {
    "\$msg" | Out-File \$logFile -Append
    Write-Host \$msg
}

# 0. Unblock the zip file just in case
Write-Log "Unblocking ZIP file..."
Unblock-File -Path "$zipPath" -ErrorAction SilentlyContinue

# 1. Kill the process and wait a bit
Write-Log "Closing $exeName..."
\$processName = "$exeName".Replace(".exe", "")

# المحاولة الأولى للإغلاق بشكل لطيف
Get-Process | Where-Object { \$_.Name -eq "\$processName" -or \$_.Path -like "*$installDir*" } | Stop-Process -Force -ErrorAction SilentlyContinue

# الانتظار للتأكد من انتهاء العملية
Write-Log "Waiting for process to exit..."
\$retryCount = 0
while (\$retryCount -lt 5) {
    \$activeProcess = Get-Process | Where-Object { \$_.Name -eq "\$processName" -or \$_.Path -like "*$installDir*" }
    if (!\$activeProcess) { break }
    Write-Log "Process still active, waiting..."
    Start-Sleep -Seconds 1
    \$retryCount++
}

# 2. Extract ZIP
Write-Log "Extracting files to $extractPath ..."
if (Test-Path "$extractPath") { 
    Remove-Item "$extractPath" -Recurse -Force -ErrorAction SilentlyContinue 
}
New-Item -ItemType Directory -Path "$extractPath" -Force | Out-Null

try {
    Expand-Archive -Path "$zipPath" -DestinationPath "$extractPath" -Force -ErrorAction Stop
    Write-Log "Extraction successful."
} catch {
    Write-Log "Extraction failed: \$(\$_.Exception.Message)"
    Read-Host "Error during extraction. Press Enter to exit."
    exit
}

# 3. Find source directory
Write-Log "Searching for $exeName in extracted files..."
\$sourceDir = "$extractPath"
\$exeInExtract = Get-ChildItem -Path "$extractPath" -Filter "$exeName" -Recurse | Select-Object -First 1
if (\$exeInExtract) {
    \$sourceDir = \$exeInExtract.Directory.FullName
    Write-Log "SUCCESS: Found $exeName in: \$sourceDir"
} else {
    Write-Log "ERROR: Could not find $exeName in update files at $extractPath"
    Read-Host "Update files missing core EXE. Press Enter to exit."
    exit
}

# 4. Clean old files in installation directory
Write-Log "Cleaning old version in $installDir ..."
Get-ChildItem -Path "$installDir" | Where-Object { \$_.Name -ne "update_log.txt" -and \$_.Name -ne "data_backup" -and \$_.Name -ne "update_script.ps1" } | ForEach-Object {
    try {
        \$itemPath = \$_.FullName
        if (Test-Path \$itemPath) {
            Remove-Item \$itemPath -Recurse -Force -ErrorAction Stop
        }
    } catch {
        Write-Log "Warning: Could not delete \$(\$_.Name). It might be in use or protected."
    }
}

# 5. Copy new files
Write-Log "Copying from \$sourceDir to $installDir"
try {
    # نسخ المحتويات مع Force للتغلب على الملفات الموجودة
    Copy-Item -Path "\$sourceDir\\*" -Destination "$installDir" -Recurse -Force -ErrorAction Stop
    Write-Log "SUCCESS: Copy complete."
} catch {
    Write-Log "ERROR: Copy failed: \$(\$_.Exception.Message)"
    Write-Log "Try running the app as Administrator."
    Read-Host "Copy failed. Press Enter to exit."
    exit
}

# 6. Restart app
Write-Log "Restarting application..."
Start-Process "$currentExePath"

# 7. Cleanup
Write-Log "Cleaning up temp files..."
Start-Sleep -Seconds 2
Remove-Item "$zipPath" -Force -ErrorAction SilentlyContinue
# نترك المجلد المستخرج للحظة للتأكد من أن البرنامج بدأ
Remove-Item "$extractPath" -Recurse -Force -ErrorAction SilentlyContinue
Write-Log "Update complete!"
Start-Sleep -Seconds 1
# السكريبت سيغلق نفسه
''';

      await File(scriptPath).writeAsString(scriptContent);

      onStatusChanged('جاري إغلاق البرنامج لبدء التثبيت...');
      await Future.delayed(const Duration(seconds: 1));

      // 3. Start PowerShell using cmd.exe /c start for better compatibility with spaces
      try {
        debugPrint('Launching updater via CMD: $scriptPath');

        // استخدام "" كعنوان فارغ هو الحل السحري للمسافات في أمر start
        await Process.run('cmd.exe', [
          '/c',
          'start',
          '""', // عنوان النافذة فارغ
          'powershell.exe',
          '-NoProfile',
          '-ExecutionPolicy',
          'Bypass',
          '-File',
          '"$scriptPath"', // إضافة اقتباسات حول المسار
        ]);
      } catch (e) {
        debugPrint('Failed to start CMD/PowerShell: $e');
        onStatusChanged('فشل بدء التثبيت: $e');
        return;
      }

      exit(0);
    } catch (e) {
      debugPrint('Update error: $e');
      rethrow;
    }
  }
}
