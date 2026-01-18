import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class FirstPartAccreditationStructure extends StatelessWidget {
  const FirstPartAccreditationStructure({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Image.asset(AppImages.accreditationStructure, fit: BoxFit.cover),
          SizedBox(width: 150.w),
          const ThreeContainersRightAccreditationStructure(),
        ],
      ),
    );
  }
}
