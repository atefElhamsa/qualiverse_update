import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/features/all_features_imports/all_features_imports.dart';

class ListFileItemWidget extends StatelessWidget {
  const ListFileItemWidget({super.key, required this.fileItemModels});

  // List of file items to display.
  final List<FileItemModel> fileItemModels;

  @override
  Widget build(BuildContext context) {
    // Create a row of file items.
    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(fileItemModels.length * 2 - 1, (index) {
        if (index.isOdd) {
          return SizedBox(width: 24.w);
        }
        final itemIndex = index ~/ 2;
        return FileItemWidget(fileItemModel: fileItemModels[itemIndex]);
      }),
    );
  }
}
