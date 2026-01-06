import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../routing/all_routes_imports.dart';

class GridViewInstitutionalItemsWidget extends StatelessWidget {
  const GridViewInstitutionalItemsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
      InstitutionalAccreditationCubit,
      InstitutionalAccreditationState
    >(
      builder: (context, state) {
        if (state is InstitutionalAccreditationLoading) {
          return const CustomLoading();
        }
        if (state is InstitutionalAccreditationError) {
          return RetryWidget(
            title: state.message,
            onPressed: () {
              context
                  .read<InstitutionalAccreditationCubit>()
                  .fetchInstitutionalAccreditations(
                    academicYearId: context
                        .read<InstitutionalAccreditationCubit>()
                        .selectedYearId!,
                  );
            },
          );
        }
        if (state is InstitutionalAccreditationSuccess) {
          final accreditations = state.accreditations;
          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 2.5,
            ),
            itemBuilder: (context, index) {
              return ItemWidget(
                itemModel: institutionalItems[index],
                accreditationModel: accreditations[index],
                onTap: () {
                  context
                      .read<InstitutionalAccreditationCubit>()
                      .selectInstitutionalAccreditation(
                        accreditation: accreditations[index],
                      );
                  context.pushNamed(
                    AppRoutes.indicatorsScreen,
                    extra: IndicatorsArgs(
                      accreditationModel: accreditations[index],
                      title: "institutionalIndicators",
                      index: index,
                    ),
                  );
                },
              );
            },
            itemCount: accreditations.length,
          );
        }
        return Padding(
          padding: EdgeInsets.only(top: 100.h),
          child: Center(
            child: CustomText(
              title: "pleaseSelectYear".tr(),
              textStyle: Theme.of(context).textTheme.bodyMedium!,
            ),
          ),
        );
      },
    );
  }
}
