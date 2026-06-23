import 'package:qualiverse/features/dashboard/presentation/view/widgets/evidence_overview/evidence_overview_content.dart';
import 'package:qualiverse/features/dashboard/presentation/view/widgets/accreditation_structure/accreditation_structure_content.dart';
import 'package:qualiverse/features/dashboard/presentation/view/widgets/evidence_uploads/evidence_uploads_content.dart';
import 'package:qualiverse/features/dashboard/presentation/view/widgets/indicators_file/indicators_file_content.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DashboardTabs extends StatefulWidget {
  const DashboardTabs({super.key});

  @override
  State<DashboardTabs> createState() => _DashboardTabsState();
}

class _DashboardTabsState extends State<DashboardTabs> {
  int selectedIndex = 0;

  final List<String> titles = [
    'evidenceOverview',
    'accreditationStructure',
    'evidenceUploads',
    // 'programVsInstitution',
    'indicatorsAndFiles',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            children: titles.asMap().entries.expand((entry) {
              int index = entry.key;
              return [
                Expanded(
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      child: AnimatedContainer(
                        height: 90.h,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        decoration: BoxDecoration(
                          color: selectedIndex == index
                              ? AppColors.viewAndDeleteIconColor
                              : Theme.of(context).scaffoldBackgroundColor ==
                                    AppColors.white
                              ? Colors.white
                              : AppColors.mainBlack,
                          borderRadius: BorderRadius.circular(16.r),
                          border: Border.all(
                            color: selectedIndex == index
                                ? Colors.transparent
                                : Colors.grey.withOpacity(0.15),
                            width: 1.5,
                          ),
                          boxShadow: [
                            if (selectedIndex == index)
                              BoxShadow(
                                color: AppColors.viewAndDeleteIconColor
                                    .withOpacity(0.3),
                                offset: const Offset(0, 8),
                                spreadRadius: 0,
                                blurRadius: 20,
                              )
                            else
                              BoxShadow(
                                color: Colors.black.withOpacity(0.02),
                                offset: const Offset(0, 4),
                                spreadRadius: 0,
                                blurRadius: 10,
                              ),
                          ],
                        ),
                        child: Center(
                          child: CustomText(
                            title: titles[index].tr(),
                            textAlign: TextAlign.center,
                            textStyle: Theme.of(context).textTheme.bodyMedium!
                                .copyWith(
                                  fontWeight: selectedIndex == index
                                      ? FontWeight.w700
                                      : FontWeight.w600,
                                  fontSize: 20.sp,
                                  color: selectedIndex == index
                                      ? AppColors.white
                                      : Theme.of(context)
                                                .textTheme
                                                .bodyMedium
                                                ?.color
                                                ?.withOpacity(0.6) ??
                                            Colors.grey.shade700,
                                ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                if (index != titles.length - 1) SizedBox(width: 15.w),
              ];
            }).toList(),
          ),
        ),
        const SizedBox(height: 24),
        [
          const EvidenceOverviewContent(),
          const AccreditationStructureContent(),
          const EvidenceUploadsContent(),
          // const ProgramInstitutionContent(),
          const IndicatorsFileContent(),
        ][selectedIndex],
        const SizedBox(height: 24),
      ],
    );
  }
}
