import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class CriterionsContent extends StatefulWidget {
  const CriterionsContent({super.key});

  @override
  State<CriterionsContent> createState() => _CriterionsContentState();
}

class _CriterionsContentState extends State<CriterionsContent> {
  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  void _fetchData() {
    final yearId = AcademicYearCubit.get(context).selectedAcademicYear?.id;
    final deptId = DepartmentCubit.get(context).selectedDepartment?.id;

    final typesCubit = TypesCubit.get(context);
    final typeState = typesCubit.state;
    final typeId = (typeState is TypesSuccess && typeState.selectedIndex != -1)
        ? typeState.types[typeState.selectedIndex].id
        : null;

    if (yearId != null) {
      context.read<CriterionsCubit>().fetchCriterions(
        academicYearId: yearId,
        departmentId: deptId,
        accreditationTypeId: typeId,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AcademicYearCubit, AcademicYearState>(
          listener: (context, state) => _fetchData(),
        ),
        BlocListener<DepartmentCubit, DepartmentState>(
          listener: (context, state) {
            if (state is DepartmentSuccess) _fetchData();
          },
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
              _fetchData();
            }
          },
        ),
      ],
      child: Container(
        padding: const EdgeInsets.all(20),
        margin: EdgeInsetsDirectional.only(
          start: 30.w,
          end: 30.w,
          bottom: 20.h,
        ),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CriterionsTopBar(),
            SizedBox(height: 20.h),
            BlocBuilder<CriterionsCubit, CriterionsState>(
              builder: (context, state) {
                if (state is CriterionsLoading) {
                  return const Center(child: CustomLoading());
                }

                if (state is CriterionsError) {
                  return Center(
                    child: CustomText(
                      title: state.message,
                      textStyle: Theme.of(context).textTheme.headlineLarge!,
                    ),
                  );
                }

                if (state is CriterionsSuccess) {
                  return Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFFE5E7EB)),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: CriterionsTable(criterions: state.criterions),
                  );
                }

                return const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}
