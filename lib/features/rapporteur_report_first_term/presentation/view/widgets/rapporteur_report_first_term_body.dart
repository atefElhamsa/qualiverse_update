import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';
import 'package:qualiverse/features/courses_first_term/presentation/view/widgets/courses_list.dart';
import 'package:qualiverse/features/courses_first_term/presentation/view/widgets/second_term_button.dart';
import 'package:qualiverse/features/rapporteur_report_first_term/presentation/view/widgets/rapporteur_report_top.dart';
import 'package:qualiverse/routing/app_routes.dart';

class RapporteurReportFirstTermBody extends StatelessWidget {
  const RapporteurReportFirstTermBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      widget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const RapporteurReportTop(),
          const SizedBox(height: 22),
          const CoursesList(),
          Padding(
            padding: EdgeInsets.only(top: 50.h, bottom: 10.w),
            child: FirstAndSecondTermButton(
              mainAxisAlignment: MainAxisAlignment.end,
              title: "secondTerm",
              onPressed: () {
                context.pushNamed(AppRoutes.rapporteurReportSecondTermScreen);
              },
            ),
          ),
        ],
      ),
    );
  }
}
