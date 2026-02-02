import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import "package:http/http.dart" as http;

const versionJsonUrl =
    'https://raw.githubusercontent.com/atefElhamsa/qualiverse_update/main/version.json';

Future<void> main() async {
  if (kDebugMode) {
    print('Checking for updates...');
  }

  try {
    // 1️⃣ اقرأ ملف version.json من GitHub
    final res = await http.get(Uri.parse(versionJsonUrl));
    if (res.statusCode != 200) {
      if (kDebugMode) {
        print('Failed to fetch version.json');
      }
      return;
    }

    final data = jsonDecode(res.body);
    final String latestVersion = data['version'];
    final String url = data['url'];
    final bool force = data['force'] == true;
    final String notes = data['notes'] ?? '';

    final exePath = getQualiversePath();
    if (!File(exePath).existsSync()) {
      print('Qualiverse.exe not found at $exePath');
      return;
    }

    final currentVersion = await getCurrentVersion(exePath);

    if (!isNewer(latestVersion, currentVersion)) {
      print('Already up to date ✅');
      return;
    }

    print('Update available: $latestVersion');
    if (notes.isNotEmpty) print('Notes: $notes');

    // 2️⃣ نزل الملف الجديد
    await downloadAndReplace(url, exePath);

    // 3️⃣ شغّل النسخة الجديدة
    Process.start(exePath, []);
    exit(0);
  } catch (e) {
    print('Update failed: $e');
  }
}

String getQualiversePath() {
  // نفترض إنه في نفس مجلد updater.exe
  final dir = Directory.current.path;
  return '$dir/Qualiverse.exe';
}

Future<String> getCurrentVersion(String exePath) async {
  // لو ما عندكش طريقة داخلية لجلب النسخة، اعمل افتراض إنها موجودة version.json
  // او نقدر نخلي updater يقارن بالـ exe مباشرة لو فيه نسخة
  return '0.0.0'; // افتراضي لو مش موجود
}

bool isNewer(String latest, String current) {
  List<int> parse(String v) =>
      v.split('.').map((e) => int.tryParse(e) ?? 0).toList();
  final l = parse(latest);
  final c = parse(current);

  for (int i = 0; i < 3; i++) {
    if (l[i] > c[i]) return true;
    if (l[i] < c[i]) return false;
  }
  return false;
}

Future<void> downloadAndReplace(String url, String exePath) async {
  print('Downloading new version...');
  final response = await http.get(Uri.parse(url));
  final tempExe = '$exePath.new';

  final file = File(tempExe);
  await file.writeAsBytes(response.bodyBytes);

  // استبدال الملف القديم
  final oldFile = File(exePath);
  if (oldFile.existsSync()) oldFile.deleteSync();

  File(tempExe).renameSync(exePath);
  print('Update applied successfully ✅');
}
