import 'package:qualiverse/features/dashboard/presentation/view/widgets/evidence_overview/evidence_overview_content.dart';
import 'package:qualiverse/features/dashboard/presentation/view/widgets/accreditation_structure/accreditation_structure_content.dart';
import 'package:qualiverse/features/dashboard/presentation/view/widgets/evidence_uploads/evidence_uploads_content.dart';
import 'package:qualiverse/features/dashboard/presentation/view/widgets/program_institution/program_institution_content.dart';
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
    'programVsInstitution',
    'indicatorsAndFiles',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: titles.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 2.8,
          ),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
              },
              child: AnimatedContainer(
                constraints: BoxConstraints(minWidth: 214.w, minHeight: 87.h),
                duration: const Duration(milliseconds: 200),
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
                      : Theme.of(context).scaffoldBackgroundColor ==
                            AppColors.white
                      ? AppColors.grey
                      : AppColors.mainBlack,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Center(
                  child: CustomText(
                    title: titles[index].tr(),
                    textAlign: TextAlign.center,
                    textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: selectedIndex == index
                          ? AppColors.white
                          : Theme.of(context).colorScheme.onSecondary,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 24),
        [
          const EvidenceOverviewContent(),
          const AccreditationStructureContent(),
          const EvidenceUploadsContent(),
          const ProgramInstitutionContent(),
          const IndicatorsFileContent(),
        ][selectedIndex],
        const SizedBox(height: 24),
      ],
    );
  }
}
