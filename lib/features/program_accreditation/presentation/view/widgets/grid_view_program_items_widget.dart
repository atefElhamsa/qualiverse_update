import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../routing/all_routes_imports.dart';

class GridViewProgramItemsWidget extends StatelessWidget {
  const GridViewProgramItemsWidget({super.key});

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
          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 20,
              crossAxisSpacing: 30,
              childAspectRatio: 4,
            ),
            itemBuilder: (context, index) {
              return ItemWidget(
                itemModel: programItems[index],
                accreditationModel: accreditations[index],
                onTap: () {
                  context
                      .read<ProgramAccreditationCubit>()
                      .selectProgramAccreditation(
                        accreditation: accreditations[index],
                      );
                  context.pushNamed(AppRoutes.accreditationListScreen);
                },
              );
            },
            itemCount: accreditations.length,
          );
        }
        return const SizedBox();
      },
    );
  }
}
