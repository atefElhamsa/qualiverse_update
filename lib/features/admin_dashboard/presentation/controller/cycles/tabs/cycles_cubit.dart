import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../routing/all_routes_imports.dart';

class CycleTabsCubit extends Cubit<CycleTabsState> {
  CycleTabsCubit() : super(CycleTabsInitial());

  CycleTab currentTab = CycleTab.overview;

  void changeTab(CycleTab tab) {
    currentTab = tab;
    emit(CycleTabsChanged());
  }
}

enum CycleTab { overview, courses, criterions, indicators, assignments }

extension StringCasingExtension on String {
  String capitalizeFirst() {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1).toLowerCase();
  }
}

double getTextWidth(String text) {
  final textPainter = TextPainter(
    text: TextSpan(
      text: text,
      style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
    ),
    maxLines: 1,
    textDirection: TextDirection.ltr,
  )..layout();

  return textPainter.width;
}
