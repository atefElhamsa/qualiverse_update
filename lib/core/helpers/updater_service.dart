import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:auto_updater/auto_updater.dart';

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
            await _showForcedUpdateDialog(context);
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

      final l = cleanLatest.split('.').map((e) => int.tryParse(e) ?? 0).toList();
      final c = cleanCurrent.split('.').map((e) => int.tryParse(e) ?? 0).toList();

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

  static Future<void> _showForcedUpdateDialog(BuildContext context) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => PopScope(
        canPop: false,
        child: AlertDialog(
          title: const Row(
            children: [
              Icon(Icons.warning_amber_rounded, color: Colors.red, size: 30),
              SizedBox(width: 10),
              Text('تحديث إجباري مطلوب', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
            ],
          ),
          content: const Text(
            'تم إطلاق إصدار جديد من البرنامج ويحتوي على تعديلات هامة.\nيجب عليك تثبيت التحديث لتتمكن من الاستمرار في استخدام البرنامج.',
            style: TextStyle(fontSize: 16),
          ),
          actions: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent, 
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                onPressed: () {
                  // استدعاء نظام التحديث ليظهر الشاشة ويبدأ التحميل
                  autoUpdater.checkForUpdates(inBackground: false);
                },
                child: const Text('بدء التحديث الآن', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}