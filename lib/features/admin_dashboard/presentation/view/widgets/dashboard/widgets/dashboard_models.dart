import 'package:flutter/material.dart';

class ChartData {
  final String label;
  final double value;
  final Color color;
  ChartData(this.label, this.value, this.color);
}

class LegendItem {
  final String title, subtitle, value;
  final Color color;
  LegendItem({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.color,
  });
}

class AlertItem {
  final String title, subtitle;
  final IconData icon;
  final Color color;
  AlertItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
  });
}

class UserSummaryItem {
  final String title, subtitle, value;
  final IconData icon;
  final Color color;
  UserSummaryItem({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.icon,
    required this.color,
  });
}
