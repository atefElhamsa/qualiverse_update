import 'package:flutter/material.dart';
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
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(3, (index) {
        return FileItemWidget(fileItemModel: fileItemModels[index]);
      }),
    );
  }
}
