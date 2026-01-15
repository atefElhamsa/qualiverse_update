import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../routing/all_routes_imports.dart';

class FirstContainer extends StatelessWidget {
  const FirstContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return ContainerWidget(
      widget: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: ItemTextWidgetForContainer(title: "report")),
          SizedBox(width: 30.w),
          Expanded(child: ItemTextWidgetForContainer(title: "description")),
        ],
      ),
    );
  }
}
