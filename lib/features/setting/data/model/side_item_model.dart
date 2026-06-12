import 'package:flutter/material.dart';

class SideItemModel<T> {
  final String title;
  final T page;
  final T selectedPage;
  final VoidCallback onTap;
  final IconData icon;

  SideItemModel({
    required this.title,
    required this.page,
    required this.selectedPage,
    required this.onTap,
    required this.icon,
  });

  bool get isSelected => page == selectedPage;
}
