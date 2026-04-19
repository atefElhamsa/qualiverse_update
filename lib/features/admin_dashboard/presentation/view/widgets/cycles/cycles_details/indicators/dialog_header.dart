import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../../core/all_core_imports/all_core_imports.dart';

class DialogHeader extends StatelessWidget {
  const DialogHeader({super.key, required this.onClose});

  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          title: 'Assign Indicator',
          textStyle: Theme.of(
            context,
          ).textTheme.titleLarge!.copyWith(fontSize: 18.sp),
        ),
        IconButton(onPressed: onClose, icon: const Icon(Icons.close)),
      ],
    );
  }
}
