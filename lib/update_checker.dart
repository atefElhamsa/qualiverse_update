import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> checkForUpdate(BuildContext context) async {
  try {
    final packageInfo = await PackageInfo.fromPlatform();
    final currentVersion = packageInfo.version;

    final res = await Dio().get(
      'https://raw.githubusercontent.com/QualiVerse/QualiVerse-qualiverse-frontend/dev/version.json',
    );

    final latest = res.data['version'];
    final force = res.data['force'];
    final url = res.data['url'];
    final notes = res.data['notes'];

    if (latest != currentVersion) {
      showDialog(
        barrierDismissible: !force,
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Update Available'),
          content: Text(notes),
          actions: [
            TextButton(
              onPressed: () async {
                if (await canLaunchUrl(Uri.parse(url))) {
                  await launchUrl(Uri.parse(url));
                }
              },
              child: const Text('Update Now'),
            ),
          ],
        ),
      );
    }
  } catch (e) {
    if (kDebugMode) {
      print('Error checking update: $e');
    }
  }
}
