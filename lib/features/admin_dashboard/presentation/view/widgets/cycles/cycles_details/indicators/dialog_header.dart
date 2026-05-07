import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../../core/all_core_imports/all_core_imports.dart';
import 'package:easy_localization/easy_localization.dart';

class DialogHeader extends StatelessWidget {
  const DialogHeader({super.key, required this.onClose});

  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          title: 'assignIndicator'.tr(),
          textStyle: Theme.of(
            context,
          ).textTheme.titleLarge!.copyWith(fontSize: 15.sp),
        ),
        IconButton(onPressed: onClose, icon: const Icon(Icons.close)),
      ],
    );
  }
}
