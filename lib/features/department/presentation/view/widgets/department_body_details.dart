import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

// Widget to display three buttons in a row.
class DepartmentBodyDetails extends StatelessWidget {
  const DepartmentBodyDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 650.w,
        margin: EdgeInsets.symmetric(vertical: 40.h),
        padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 50.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 30,
              offset: const Offset(0, 10),
            ),
          ],
          border: Border.all(color: AppColors.greyLight.withOpacity(0.2)),
        ),
        child: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SelectedYearAndDepartmentWidget(),
            SizedBox(height: 60),
            StandardButton(),
          ],
        ),
      ),
    );
  }
}
