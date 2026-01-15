import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../routing/all_routes_imports.dart';

class SecondContainer extends StatelessWidget {
  const SecondContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return ContainerWidget(
      widget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: ItemTextWidgetForContainer(title: "statistics")),
              SizedBox(width: 30.w),
              Expanded(child: ItemTextWidgetForContainer(title: "surveys")),
            ],
          ),
          SizedBox(height: 24.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ItemTextWidgetForContainer(title: "documentaryAnalysis"),
              ),
              SizedBox(width: 30.w),
              Expanded(child: SizedBox()),
            ],
          ),
        ],
      ),
    );
  }
}
