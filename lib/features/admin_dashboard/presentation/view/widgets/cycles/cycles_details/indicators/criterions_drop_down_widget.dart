import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../../routing/all_routes_imports.dart';

class CriterionsDropDownWidget extends StatefulWidget {
  const CriterionsDropDownWidget({super.key});

  @override
  State<CriterionsDropDownWidget> createState() =>
      _CriterionsDropDownWidgetState();
}

class _CriterionsDropDownWidgetState extends State<CriterionsDropDownWidget> {
  @override
  void initState() {
    super.initState();
    context.read<ProgramAccreditationCubit>().fetchProgramAccreditations(
      academicYearId: AcademicYearCubit.get(context).selectedAcademicYear!.id,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProgramAccreditationCubit, ProgramAccreditationState>(
      builder: (context, state) {
        if (state is ProgramAccreditationLoading) {
          return const CustomLoading();
        }
        if (state is ProgramAccreditationError) {
          return RetryWidget(
            title: state.message,
            onPressed: () {
              context
                  .read<ProgramAccreditationCubit>()
                  .fetchProgramAccreditations(
                    academicYearId: AcademicYearCubit.get(
                      context,
                    ).selectedAcademicYear!.id,
                    departmentId: DepartmentCubit.get(
                      context,
                    ).selectedDepartment?.id,
                  );
            },
          );
        }
        if (state is ProgramAccreditationSuccess) {
          final accreditations = state.accreditations;
          final isValid = accreditations.any(
            (e) => e.id == state.selectedAccreditation?.id,
          );
          return Container(
            height: 54.h,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFCCCCCC)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<int>(
                value: isValid ? state.selectedAccreditation?.id : null,
                hint: Text('selectTheCriterion'.tr()),
                icon: Icon(Icons.keyboard_arrow_down, size: 20.sp),
                style: TextStyle(
                  fontSize: 15.sp,
                  color: const Color(0xFF333333),
                ),
                items: accreditations
                    .map(
                      (accreditation) => DropdownMenuItem<int>(
                        value: accreditation.id,
                        child: Text(
                          accreditation.name,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (val) {
                  if (val == null) return;
                  final selectedModel = accreditations.firstWhere(
                    (d) => d.id == val,
                  );
                  context
                      .read<ProgramAccreditationCubit>()
                      .selectProgramAccreditation(accreditation: selectedModel);
                  context.read<CycleIndicatorCubit>().fetchCycleIndicators(
                    yearId: AcademicYearCubit.get(
                      context,
                    ).selectedAcademicYear!.id,
                    departmentId: DepartmentCubit.get(
                      context,
                    ).selectedDepartment!.id,
                    criterionId: selectedModel.id,
                  );
                },
              ),
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
