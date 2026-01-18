import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/features/all_features_imports/all_features_imports.dart';

import '../../../../../core/all_core_imports/all_core_imports.dart';

class DashboardTabs extends StatefulWidget {
  const DashboardTabs({super.key});

  @override
  State<DashboardTabs> createState() => _DashboardTabsState();
}

class _DashboardTabsState extends State<DashboardTabs> {
  int selectedIndex = 0;

  final List<String> titles = [
    'evidence_overview',
    'accreditation_structure',
    'evidence_uploads',
    'program_vs_institution',
    'indicators_and_files',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Row(
            children: List.generate(titles.length, (index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                child: AnimatedContainer(
                  constraints: BoxConstraints(minWidth: 214.w, minHeight: 87.h),
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.mainBlack.withOpacity(0.25),
                        offset: const Offset(0, 4),
                        spreadRadius: 0,
                        blurRadius: 4,
                      ),
                    ],
                    color: selectedIndex == index
                        ? AppColors.viewAndDeleteIconColor
                        : AppColors.grey,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Center(
                    child: CustomText(
                      title: titles[index].tr(),
                      textAlign: TextAlign.center,
                      textStyle: Theme.of(context).textTheme.bodyMedium!
                          .copyWith(
                            color: selectedIndex == index
                                ? AppColors.white
                                : AppColors.black,
                          ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
        const SizedBox(height: 24),
        IndexedStack(
          index: selectedIndex,
          children: [
            const EvidenceOverviewContent(),
            const AccreditationStructureContent(),
            const EvidenceUploadsContent(),
            const ProgramInstitutionContent(),
            const IndicatorsFileContent(),
          ],
        ),
      ],
    );
  }
}
