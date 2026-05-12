import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

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
      // تنظيف إصدارات البرنامج من أي زيادات مثل +13 أو -beta
      String cleanLatest = latest.split('+')[0].split('-')[0];
      String cleanCurrent = current.split('+')[0].split('-')[0];

      final l = cleanLatest.split('.').map((e) => int.tryParse(e) ?? 0).toList();
      final c = cleanCurrent.split('.').map((e) => int.tryParse(e) ?? 0).toList();

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
    final tempDir = await getTemporaryDirectory();
    
    // استخدام p.join لضمان المسارات الصحيحة على ويندوز
    final zipPath = p.join(tempDir.path, 'update.zip');
    final extractPath = p.join(tempDir.path, 'update_extracted');
    final logPath = p.join(tempDir.path, 'update_log.txt');
    final scriptPath = p.join(tempDir.path, 'update_script.ps1');

    final currentExePath = Platform.resolvedExecutable;
    final installDir = File(currentExePath).parent.path;
    final exeName = p.basename(currentExePath);

    try {
      // 1. Download
      onStatusChanged('جاري تحميل التحديث...');
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
      final scriptContent = '''
\$logFile = "$logPath"
"--- Update started at \$(Get-Date) ---" | Out-File \$logFile
"Install Dir: $installDir" | Out-File \$logFile -Append

function Write-Log(\$msg) {
    "\$msg" | Out-File \$logFile -Append
    Write-Host \$msg
}

# 1. Kill the process and wait a bit
Write-Log "Closing $exeName..."
\$processName = "$exeName".Replace(".exe", "")
# إغلاق البرنامج وأي عملية مرتبطة بالمجلد ده
Get-Process | Where-Object { \$_.Name -eq "\$processName" -or \$_.Path -like "*$installDir*" } | Stop-Process -Force -ErrorAction SilentlyContinue
Start-Sleep -Seconds 3

# 2. Extract ZIP
Write-Log "Extracting files..."
if (Test-Path "$extractPath") { 
    Remove-Item "$extractPath" -Recurse -Force -ErrorAction SilentlyContinue 
}
New-Item -ItemType Directory -Path "$extractPath" -Force | Out-Null

try {
    Expand-Archive -Path "$zipPath" -DestinationPath "$extractPath" -Force -ErrorAction Stop
    Write-Log "Extraction successful."
} catch {
    Write-Log "Extraction failed: \$(\$_.Exception.Message)"
    Read-Host "Press Enter to exit"
    exit
}

# 3. Find source directory (handle nested folders in zip)
Write-Log "Searching for $exeName in extracted files..."
\$sourceDir = "$extractPath"
\$exeInExtract = Get-ChildItem -Path "$extractPath" -Filter "$exeName" -Recurse | Select-Object -First 1
if (\$exeInExtract) {
    \$sourceDir = \$exeInExtract.Directory.FullName
    Write-Log "SUCCESS: Found $exeName in: \$sourceDir"
} else {
    Write-Log "ERROR: Could not find $exeName in update files at $extractPath"
    Read-Host "Press Enter to exit"
    exit
}

# 4. Clean old files in installation directory
Write-Log "Cleaning old version..."
# مسح كل شيء عدا ملفات معينة نريد الإبقاء عليها
Get-ChildItem -Path "$installDir" | Where-Object { \$_.Name -ne "update_log.txt" -and \$_.Name -ne "data_backup" } | ForEach-Object {
    try {
        \$itemPath = \$_.FullName
        if (Test-Path \$itemPath) {
            Remove-Item \$itemPath -Recurse -Force -ErrorAction SilentlyContinue
        }
    } catch {
        Write-Log "Warning: Busy file \$(\$_.Name)"
    }
}

# 5. Copy new files
Write-Log "Copying from \$sourceDir to $installDir"
try {
    # التأكد من وجود ملفات في المصدر
    \$filesCount = (Get-ChildItem -Path "\$sourceDir" -Recurse).Count
    Write-Log "Found \$filesCount files to copy."
    
    Copy-Item -Path "\$sourceDir\\*" -Destination "$installDir" -Recurse -Force -ErrorAction Stop
    Write-Log "SUCCESS: Copy complete."
} catch {
    Write-Log "ERROR: Copy failed: \$(\$_.Exception.Message)"
    Read-Host "Press Enter to exit"
    exit
}

# 6. Restart app
Write-Log "Restarting..."
Start-Process "$currentExePath"

# 7. Cleanup
Write-Log "Cleaning up temp files..."
Remove-Item "$zipPath" -Force -ErrorAction SilentlyContinue
Remove-Item "$extractPath" -Recurse -Force -ErrorAction SilentlyContinue
Write-Log "Update complete!"
Start-Sleep -Seconds 2
''';

      await File(scriptPath).writeAsString(scriptContent);

      onStatusChanged('جاري إغلاق البرنامج لبدء التثبيت...');
      await Future.delayed(const Duration(seconds: 1));

      // 3. Start PowerShell with Window visible for debugging
      await Process.start('powershell.exe', [
        '-NoProfile',
        '-ExecutionPolicy',
        'Bypass',
        '-Command',
        'Start-Process powershell.exe -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$scriptPath`"" -Verb RunAs'
      ], mode: ProcessStartMode.detached);

      exit(0);
    } catch (e) {
      debugPrint('Update error: $e');
      rethrow;
    }
  }
}
