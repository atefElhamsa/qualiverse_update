import 'package:flutter/material.dart';

class NotificationSettingsContent extends StatelessWidget {
  const NotificationSettingsContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Notification Settings',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}
