import 'package:flutter/animation.dart';

class SideItemModel {
  final String title;
  final int index;
  final int selectedIndex;
  final VoidCallback onTap;

  SideItemModel({
    required this.title,
    required this.index,
    required this.selectedIndex,
    required this.onTap,
  });
}
