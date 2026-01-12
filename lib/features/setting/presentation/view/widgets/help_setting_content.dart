import 'package:flutter/material.dart';

class HelpSettingsContent extends StatelessWidget {
  const HelpSettingsContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Help',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}
