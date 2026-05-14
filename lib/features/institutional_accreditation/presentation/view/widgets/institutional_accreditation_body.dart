import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';
import 'package:qualiverse/features/all_features_imports/all_features_imports.dart';

class InstitutionalAccreditationBody extends StatefulWidget {
  const InstitutionalAccreditationBody({super.key});

  @override
  State<InstitutionalAccreditationBody> createState() =>
      _InstitutionalAccreditationBodyState();
}

class _InstitutionalAccreditationBodyState
    extends State<InstitutionalAccreditationBody> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkAndFetch();
    });
  }

  Future<void> _checkAndFetch() async {
    final yearCubit = context.read<AcademicYearCubit>();
    final yearState = yearCubit.state;
    
    if (yearState is AcademicYearSuccess && yearState.academicYears.isNotEmpty) {
      final selectedYear = yearState.selectedAcademicYear ?? 
          yearState.academicYears.reduce((a, b) => a.yearNumber > b.yearNumber ? a : b);
      
      if (yearState.selectedAcademicYear == null) {
        yearCubit.selectAcademicYear(academicYear: selectedYear);
      }

        final instCubit = context.read<InstitutionalAccreditationCubit>();
        final typeState = context.read<TypesCubit>().state;
        int? typeId;

        if (typeState is TypesSuccess && typeState.types.isNotEmpty) {
          try {
            typeId = typeState.types
                .firstWhere(
                  (t) =>
                      t.name.toLowerCase().contains("institutional") ||
                      t.name.contains("مؤسسي"),
                )
                .id;
          } catch (e) {
            // Fallback to first type if not found by name
            typeId = typeState.types.first.id;
          }
        }

        final meState = context.read<MeCubit>().state;
        final isAdmin = meState is MeSuccess && meState.meModel.role == 'admin';

        instCubit.fetchInstitutionalAccreditations(
          academicYearId: selectedYear.id,
          accreditationTypeId: typeId,
          isAdmin: isAdmin,
        );
        instCubit.selectedYearId = selectedYear.id;
    }
  }

  @override
  Widget build(BuildContext context) {
    final inherited = HomeBodyInherited.of(context);
    return BlocListener<AcademicYearCubit, AcademicYearState>(
      listener: (context, state) {
        _checkAndFetch();
      },
      child: CustomScaffold(
        onRefresh: () => _checkAndFetch(),
        widget: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomScaffoldTop(controller: inherited.controller),
            Center(
              child: CustomText(
                title: AppTexts.institutionalAccreditationEnglish,
                textStyle: Theme.of(context).textTheme.displayLarge!,
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: CustomText(
                title: AppTexts.institutionalAccreditationArabic,
                textStyle: Theme.of(
                  context,
                ).textTheme.bodyMedium!.copyWith(fontSize: 32.sp),
              ),
            ),
            const SizedBox(height: 10),
            const SelectYear(),
            const SizedBox(height: 30),
            const GridViewInstitutionalItemsWidget(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
