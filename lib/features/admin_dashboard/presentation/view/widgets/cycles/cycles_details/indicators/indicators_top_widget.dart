import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/features/admin_dashboard/presentation/view/widgets/cycles/cycles_details/indicators/accreditation_type_drop_down_widget.dart';

import '../../../../../../../../routing/all_routes_imports.dart';

class IndicatorsTopWidget extends StatelessWidget {
  const IndicatorsTopWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AcademicYearCubit, AcademicYearState>(
          listener: (context, state) => _fetchCriterions(context),
        ),
        BlocListener<DepartmentCubit, DepartmentState>(
          listener: (context, state) => _fetchCriterions(context),
        ),
        BlocListener<TypesCubit, TypesState>(
          listener: (context, state) {
            if (state is TypesSuccess && state.selectedIndex != -1) {
              final selectedType = state.types[state.selectedIndex];
              final name = selectedType.name.toLowerCase();
              final deptCubit = DepartmentCubit.get(context);

              if (name.contains('program') || name.contains('برامجي')) {
                if (deptCubit.selectedDepartment == null &&
                    deptCubit.state is DepartmentSuccess) {
                  final departments =
                      (deptCubit.state as DepartmentSuccess).departments;
                  if (departments.isNotEmpty) {
                    deptCubit.selectDepartment(department: departments.first);
                  }
                }
              } else if (name.contains('institutional') ||
                  name.contains('مؤسسي')) {
                deptCubit.selectDepartment(department: null);
              }
              _fetchCriterions(context);
            }
          },
        ),
        BlocListener<ProgramAccreditationCubit, ProgramAccreditationState>(
          listener: (context, state) {
            if (state is ProgramAccreditationSuccess &&
                state.selectedAccreditation != null) {
              _fetchIndicators(context, state.selectedAccreditation!);
            }
          },
        ),
      ],
      child: BlocBuilder<TypesCubit, TypesState>(
        builder: (context, state) {
          bool isInstitutional = false;
          if (state is TypesSuccess && state.selectedIndex != -1) {
            final selectedType = state.types[state.selectedIndex];
            if (selectedType.name.toLowerCase().contains('institutional') ||
                selectedType.name.toLowerCase().contains('مؤسسي')) {
              isInstitutional = true;
            }
          }

          return Row(
            children: [
              const Expanded(flex: 2, child: AccreditationTypeDropDownWidget()),
              SizedBox(width: 10.w),
              Expanded(
                flex: 3,
                child: DepartmentDropDownWidget(isDisabled: isInstitutional),
              ),
              SizedBox(width: 10.w),
              const Expanded(flex: 7, child: CriterionsDropDownWidget()),
            ],
          );
        },
      ),
    );
  }

  void _fetchCriterions(BuildContext context) {
    final yearId = AcademicYearCubit.get(context).selectedAcademicYear?.id;
    final deptId = DepartmentCubit.get(context).selectedDepartment?.id;
    final typesCubit = TypesCubit.get(context);
    final typeState = typesCubit.state;

    if (yearId != null &&
        typeState is TypesSuccess &&
        typeState.selectedIndex != -1) {
      final typeId = typeState.types[typeState.selectedIndex].id;
      ProgramAccreditationCubit.get(context).fetchProgramAccreditations(
        academicYearId: yearId,
        departmentId: deptId,
        accreditationTypeId: typeId,
      );
    }
  }

  void _fetchIndicators(
    BuildContext context,
    AccreditationModel selectedModel,
  ) {
    final yearId = AcademicYearCubit.get(context).selectedAcademicYear?.id;
    final deptId = DepartmentCubit.get(context).selectedDepartment?.id;

    if (yearId != null) {
      context.read<CycleIndicatorCubit>().fetchCycleIndicators(
        yearId: yearId,
        departmentId: deptId,
        criterionId: selectedModel.id,
      );
    }
  }
}
