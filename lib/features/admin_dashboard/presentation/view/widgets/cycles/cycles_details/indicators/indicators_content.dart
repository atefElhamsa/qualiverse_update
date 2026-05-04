import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../../routing/all_routes_imports.dart';

class IndicatorsContent extends StatefulWidget {
  const IndicatorsContent({super.key});

  @override
  State<IndicatorsContent> createState() => _IndicatorsContentState();
}

class _IndicatorsContentState extends State<IndicatorsContent> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _syncAndFetchInitialData();
    });
  }

  void _syncAndFetchInitialData() {
    final yearId = AcademicYearCubit.get(context).selectedAcademicYear?.id;
    final typeState = TypesCubit.get(context).state;
    final deptCubit = DepartmentCubit.get(context);

    if (yearId != null &&
        typeState is TypesSuccess &&
        typeState.selectedIndex != -1) {
      final selectedType = typeState.types[typeState.selectedIndex];
      final typeName = selectedType.name.toLowerCase();

      // Sync department based on type
      if (typeName.contains('institutional') || typeName.contains('مؤسسي')) {
        deptCubit.selectDepartment(department: null);
      } else if (typeName.contains('program') || typeName.contains('برامجي')) {
        if (deptCubit.selectedDepartment == null &&
            deptCubit.state is DepartmentSuccess) {
          final departments =
              (deptCubit.state as DepartmentSuccess).departments;
          if (departments.isNotEmpty) {
            deptCubit.selectDepartment(department: departments.first);
            // The listener in IndicatorsTopWidget will handle the fetch when department changes
            return;
          }
        }
      }

      // Initial fetch if no department change was needed
      ProgramAccreditationCubit.get(context).fetchProgramAccreditations(
        academicYearId: yearId,
        departmentId: deptCubit.selectedDepartment?.id,
        accreditationTypeId: selectedType.id,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DepartmentCubit, DepartmentState>(
      listener: (context, state) {
        if (state is DepartmentSuccess) {
          final typeState = TypesCubit.get(context).state;
          if (typeState is TypesSuccess && typeState.selectedIndex != -1) {
            final typeName = typeState.types[typeState.selectedIndex].name
                .toLowerCase();
            if (typeName.contains('program') || typeName.contains('برامجي')) {
              if (DepartmentCubit.get(context).selectedDepartment == null &&
                  state.departments.isNotEmpty) {
                DepartmentCubit.get(
                  context,
                ).selectDepartment(department: state.departments.first);
              }
            }
          }
        }
      },
      child: Container(
        margin: EdgeInsetsDirectional.only(
          start: 30.w,
          end: 30.w,
          bottom: 20.h,
        ),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.mainBlack.withOpacity(0.06),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: const Column(
          children: [IndicatorsTopWidget(), IndicatorsTable()],
        ),
      ),
    );
  }
}
