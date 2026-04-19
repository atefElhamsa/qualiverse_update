import 'package:flutter/material.dart';

class SideItemModel<T> {
  final String title;
  final T page;
  final T selectedPage;
  final VoidCallback onTap;

  SideItemModel({
    required this.title,
    required this.page,
    required this.selectedPage,
    required this.onTap,
  });

  bool get isSelected => page == selectedPage;
}
