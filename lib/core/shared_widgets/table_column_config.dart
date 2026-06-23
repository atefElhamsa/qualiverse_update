import 'package:flutter/material.dart';

class TableColumnConfig {
  final String label;
  final int flex;
  final TextAlign textAlign;

  TableColumnConfig({
    required this.label,
    this.flex = 1,
    this.textAlign = TextAlign.center,
  });

  TableColumnConfig copyWith({
    String? label,
    int? flex,
    TextAlign? textAlign,
  }) {
    return TableColumnConfig(
      label: label ?? this.label,
      flex: flex ?? this.flex,
      textAlign: textAlign ?? this.textAlign,
    );
  }
}