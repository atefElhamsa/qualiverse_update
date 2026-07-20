import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:dio/dio.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';

const String supabaseUrl = 'https://zvdfzcslziprxywgshnd.supabase.co';
const String supabaseKey = 'sb_publishable_yxkj2IvKxgeF7NiTncVcuQ_hM8CUVoA';

Future<void> trackFirstLaunch() async {
  final prefs = await SharedPreferences.getInstance();
  final alreadyTracked = prefs.getBool('device_tracked') ?? false;

  if (alreadyTracked) return;

  final deviceId = const Uuid().v4();
  final packageInfo = await PackageInfo.fromPlatform();
  final currentVersion = packageInfo.version;

  String deviceName = 'Unknown';
  try {
    final deviceInfo = DeviceInfoPlugin();
    final windowsInfo = await deviceInfo.windowsInfo;
    deviceName = windowsInfo.computerName;
  } catch (e) {
    debugPrint('Device info error: $e');
  }

  try {
    await Dio().post(
      '$supabaseUrl/rest/v1/device_installs',
      options: Options(
        headers: {
          'apikey': supabaseKey,
          'Authorization': 'Bearer $supabaseKey',
          'Content-Type': 'application/json',
        },
      ),
      data: {
        'device_id': deviceId,
        'app_version': currentVersion,
        'device_name': deviceName,
      },
    );
    await prefs.setBool('device_tracked', true);
  } catch (e) {
    debugPrint('Analytics error: $e');
  }
}
