import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../routing/all_routes_imports.dart';

class SelectYear extends StatelessWidget {
  const SelectYear({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AcademicYearCubit, AcademicYearState>(
      builder: (context, state) {
        if (state is AcademicYearLoading) {
          return const CustomLoading();
        }
        if (state is AcademicYearError) {
          return RetryWidget(
            title: state.message,
            onPressed: () {
              AcademicYearCubit.get(context).fetchAcademicYears();
            },
          );
        }
        if (state is AcademicYearSuccess) {
          final academicYearCubit = AcademicYearCubit.get(context);
          final List<int> yearNumbers = state.academicYears
              .map((e) => e.yearNumber)
              .toList();

          final int? selectedYearNumber =
              state.selectedAcademicYear?.yearNumber;
          return CustomDropButton(
            dropButtonModel: DropButtonModel(
              selectedData: selectedYearNumber,
              listOfData: yearNumbers,
              hintText: state.academicYears.isEmpty
                  ? "noYears".tr()
                  : "selectedYear".tr(),
              hintSize: 20.sp,
              onChanged: (value) {
                if (value == null) return;
                final selectedModel = state.academicYears.firstWhere(
                  (d) => d.yearNumber == value,
                );
                academicYearCubit.selectAcademicYear(
                  academicYear: selectedModel,
                );

                final typeState = context.read<TypesCubit>().state;
                final typeId = (typeState is TypesSuccess)
                    ? typeState.types
                          .firstWhere((t) => t.name.contains("Institutional"))
                          .id
                    : null;

                final meState = context.read<MeCubit>().state;
                final isAdmin =
                    meState is MeSuccess && meState.meModel.role == 'admin';

                context
                    .read<InstitutionalAccreditationCubit>()
                    .fetchInstitutionalAccreditations(
                      academicYearId: selectedModel.id,
                      accreditationTypeId: typeId,
                      isAdmin: isAdmin,
                    );
                context.read<InstitutionalAccreditationCubit>().selectedYearId =
                    selectedModel.id;
              },
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
