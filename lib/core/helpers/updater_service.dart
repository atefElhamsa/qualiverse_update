import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';

class UpdaterService {
  static String get _versionUrl =>
      'https://raw.githubusercontent.com/atefElhamsa/qualiverse_update/main/version.json?t=${DateTime.now().millisecondsSinceEpoch}';

  static Future<void> checkForUpdate(BuildContext context) async {
    try {
      final response = await http
          .get(Uri.parse(_versionUrl))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final latestVersion = data['version'] as String;

        final info = await PackageInfo.fromPlatform();
        final currentVersion = info.version;

        if (_isNewer(latestVersion, currentVersion)) {
          if (context.mounted) {
            // هذا سيعلق الشاشة تماماً حتى يقوم المستخدم بالتحديث
            await _showForcedUpdateDialog(context, latestVersion);
          }
        }
      }
    } catch (e) {
      debugPrint('Update check error: $e');
    }
  }

  static bool _isNewer(String latest, String current) {
    try {
      String cleanLatest = latest.split('+')[0].split('-')[0].trim();
      String cleanCurrent = current.split('+')[0].split('-')[0].trim();

      if (cleanLatest == cleanCurrent) return false;

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
    } catch (_) {}
    return false;
  }

  static Future<void> _showForcedUpdateDialog(
    BuildContext context,
    String latestVersion,
  ) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => PopScope(
        canPop: false,
        child: _UpdateDialogWidget(latestVersion: latestVersion),
      ),
    );
  }
}

class _UpdateDialogWidget extends StatefulWidget {
  final String latestVersion;

  const _UpdateDialogWidget({required this.latestVersion});

  @override
  State<_UpdateDialogWidget> createState() => _UpdateDialogWidgetState();
}

class _UpdateDialogWidgetState extends State<_UpdateDialogWidget> {
  bool _isDownloading = false;
  bool _isWaitingForNetwork = false;
  double _progress = 0.0;
  String _statusText = 'جاهز لبدء التحديث';
  StreamSubscription? _connectivitySubscription;

  @override
  void dispose() {
    _connectivitySubscription?.cancel();
    super.dispose();
  }

  Future<void> _startDownloadAndInstall() async {
    setState(() {
      _isDownloading = true;
      _isWaitingForNetwork = false;
      _statusText = 'جاري التحميل... يرجى الانتظار';
    });

    try {
      final exeUrl =
          'https://github.com/atefElhamsa/qualiverse_update/releases/download/v${widget.latestVersion}/qualiverse_setup.exe';
      final request = http.Request('GET', Uri.parse(exeUrl));
      final client = http.Client();

      _connectivitySubscription?.cancel();
      _connectivitySubscription = Connectivity().onConnectivityChanged.listen((
        result,
      ) {
        if (result.contains(ConnectivityResult.none)) {
          client.close(); // Abort the HTTP request immediately
          if (mounted) {
            setState(() {
              _isWaitingForNetwork = true;
              _isDownloading = false;
              _statusText =
                  'انقطع الاتصال.. في انتظار عودة الإنترنت للاستكمال أوتوماتيكياً';
            });
          }
        } else if (_isWaitingForNetwork) {
          // Network is back! Auto-resume
          if (mounted) {
            _startDownloadAndInstall();
          }
        }
      });

      final response = await client.send(request);

      if (response.statusCode != 200) {
        setState(() {
          _statusText = 'فشل التحميل. تأكد من توفر الملف على جيت هاب.';
          _isDownloading = false;
        });
        return;
      }

      final contentLength = response.contentLength ?? 0;
      final tempDir = await getTemporaryDirectory();
      final file = File(
        '${tempDir.path}\\qualiverse_setup_v${widget.latestVersion}.exe',
      );
      final sink = file.openWrite();

      int downloaded = 0;
      await response.stream.forEach((chunk) {
        sink.add(chunk);
        downloaded += chunk.length;
        if (contentLength > 0) {
          setState(() {
            _progress = downloaded / contentLength;
            _statusText =
                'جاري التحميل: ${(downloaded / 1024 / 1024).toStringAsFixed(1)} ميجا / ${(contentLength / 1024 / 1024).toStringAsFixed(1)} ميجا';
          });
        }
      });
      await sink.close();
      _connectivitySubscription?.cancel();

      setState(() {
        _statusText = 'اكتمل التحميل. جاري التحديث... التطبيق سيغلق الآن.';
      });

      final localAppData = Platform.environment['LOCALAPPDATA'];
      final exePath = '$localAppData\\QualiVerse\\qualiverse.exe';
      await Process.start(
        'powershell',
        [
          '-Command',
          'Start-Sleep -Seconds 2; \$proc = Start-Process -FilePath \'${file.path}\' -ArgumentList \'/VERYSILENT\', \'/SUPPRESSMSGBOXES\' -PassThru; \$proc.WaitForExit(); Start-Process -FilePath \'$exePath\''
        ],
        mode: ProcessStartMode.detached,
      );

      exit(0);
    } catch (e) {
      _connectivitySubscription?.cancel();
      setState(() {
        _isWaitingForNetwork = true;
        _isDownloading = false;
        _statusText =
            'انقطع الاتصال.. في انتظار عودة الإنترنت للاستكمال أوتوماتيكياً';
      });
      _connectivitySubscription = Connectivity().onConnectivityChanged.listen((
        result,
      ) {
        if (!result.contains(ConnectivityResult.none) &&
            _isWaitingForNetwork &&
            mounted) {
          _startDownloadAndInstall();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 20,
      backgroundColor: Colors.white,
      child: Container(
        width: 400,
        padding: const EdgeInsets.all(24.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            colors: [Colors.white, Color(0xFFF8FAFC)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.system_update_rounded,
                color: Colors.blue,
                size: 48,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'تحديث جديد متاح',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue[900],
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'إصدار جديد متاح الآن.\nيحتوي هذا التحديث على تحسينات هامة ولا يمكنك المتابعة بدون التحديث.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 30),
            if (_isDownloading || _isWaitingForNetwork) ...[
              if (_isWaitingForNetwork)
                const Center(child: CircularProgressIndicator())
              else
                LinearProgressIndicator(
                  value: _progress > 0 ? _progress : null,
                  backgroundColor: Colors.grey[200],
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue[700]!),
                  minHeight: 10,
                  borderRadius: BorderRadius.circular(5),
                ),
              const SizedBox(height: 12),
              Text(
                _statusText,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.blueGrey,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ] else ...[
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[700],
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                  ),
                  onPressed: _startDownloadAndInstall,
                  child: const Text(
                    'تحديث الآن',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
