import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> checkForUpdate(BuildContext context) async {
  try {
    final packageInfo = await PackageInfo.fromPlatform();
    final currentVersion = packageInfo.version;

    final res = await Dio().get(
      'https://raw.githubusercontent.com/atefElhamsa/qualiverse_update/main/version.json',
      options: Options(responseType: ResponseType.plain),
    );

    if (res.statusCode != 200 || res.data == null) {
      debugPrint('Update check failed: ${res.statusCode}');
      return;
    }

    final Map<String, dynamic> data =
        jsonDecode(res.data.toString()) as Map<String, dynamic>;

    if (!data.containsKey('version')) {
      debugPrint('Invalid update JSON format');
      return;
    }

    final latestVersion = data['version'].toString();
    final bool force = data['force'] == true;
    final String url = data['url']?.toString() ?? '';
    final String notes = data['notes']?.toString() ?? '';

    List<int> parseVersion(String v) =>
        v.split('.').map((e) => int.tryParse(e) ?? 0).toList();

    final latestParts = parseVersion(latestVersion);
    final currentParts = parseVersion(currentVersion);

    bool isUpdateAvailable = false;
    for (int i = 0; i < 3; i++) {
      if (latestParts[i] > currentParts[i]) {
        isUpdateAvailable = true;
        break;
      } else if (latestParts[i] < currentParts[i]) {
        break;
      }
    }

    if (!isUpdateAvailable) return;

    showDialog(
      context: context,
      barrierDismissible: !force,
      builder: (_) => AlertDialog(
        title: const Text('Update Available'),
        content: Text(notes.isNotEmpty ? notes : 'New version available'),
        actions: [
          TextButton(
            onPressed: () async {
              if (url.isNotEmpty) {
                final uri = Uri.parse(url);
                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri, mode: LaunchMode.externalApplication);
                }
              }
            },
            child: const Text('Update Now'),
          ),
        ],
      ),
    );
  } catch (e, s) {
    debugPrint('Error checking update: $e');
    debugPrint('$s');
  }
}
