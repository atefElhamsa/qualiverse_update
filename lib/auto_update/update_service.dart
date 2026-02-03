// import 'dart:convert';
// import 'dart:io';
//
// import 'package:http/http.dart' as http;
// import 'package:package_info_plus/package_info_plus.dart';
//
// class UpdateService {
//   static const versionUrl =
//       'https://raw.githubusercontent.com/atefElhamsa/qualiverse_update/main/version.json';
//
//   static Future<void> checkAndUpdate({
//     required Function(String notes, bool force) onUpdateAvailable,
//   }) async {
//     final packageInfo = await PackageInfo.fromPlatform();
//     final currentVersion = packageInfo.version;
//
//     final res = await http.get(Uri.parse(versionUrl));
//     if (res.statusCode != 200) return;
//
//     final data = jsonDecode(res.body);
//
//     final latestVersion = data['version'];
//     final force = data['force'] == true;
//     final notes = data['notes'] ?? '';
//
//     if (isNewer(latestVersion, currentVersion)) {
//       onUpdateAvailable(notes, force);
//
//       if (force) {
//         launchUpdater();
//       }
//     }
//   }
//
//   static bool isNewer(String latest, String current) {
//     List<int> p(String v) =>
//         v.split('.').map((e) => int.tryParse(e) ?? 0).toList();
//
//     final l = p(latest);
//     final c = p(current);
//
//     for (int i = 0; i < 3; i++) {
//       if (l[i] > c[i]) return true;
//       if (l[i] < c[i]) return false;
//     }
//     return false;
//   }
//
//   static void launchUpdater() {
//     final dir = File(Platform.resolvedExecutable).parent.path;
//     final updaterPath = '$dir\\updater.exe';
//
//     Process.start(updaterPath, []);
//     exit(0);
//   }
// }
