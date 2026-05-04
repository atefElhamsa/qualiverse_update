import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/features/admin_dashboard/presentation/view/widgets/cycles/cycles_details/indicators/accreditation_type_drop_down_widget.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';
import 'create_criterion_dialog.dart';
import 'package:easy_localization/easy_localization.dart';

class CriterionsTopBar extends StatefulWidget {
  const CriterionsTopBar({super.key});

  @override
  State<CriterionsTopBar> createState() => _CriterionsTopBarState();
}

class _CriterionsTopBarState extends State<CriterionsTopBar> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TypesCubit, TypesState>(
      builder: (context, state) {
        bool isInstitutional = false;
        if (state is TypesSuccess && state.selectedIndex != -1) {
          final selectedType = state.types[state.selectedIndex];
          final name = selectedType.name.toLowerCase();
          if (name.contains('institutional') || name.contains('مؤسسي')) {
            isInstitutional = true;
          }
        }

        return BlocListener<TypesCubit, TypesState>(
          listener: (context, state) {
            if (state is TypesSuccess && state.selectedIndex != -1) {
              final selectedType = state.types[state.selectedIndex];
              final name = selectedType.name.toLowerCase();
              if (name.contains('institutional') || name.contains('مؤسسي')) {
                DepartmentCubit.get(context).selectDepartment(department: null);
              }
            }
          },
          child: Row(
            children: [
              const Expanded(
                flex: 1,
                child: AccreditationTypeDropDownWidget(),
              ),
              SizedBox(width: 12.w),
              Expanded(
                flex: 1,
                child: CoursesDepartmentDropDownWidget(
                  height: 45.h,
                  isDisabled: isInstitutional,
                ),
              ),
              const Spacer(),
              const _CreateCriterionButton(),
            ],
          ),
        );
      },
    );
  }
}

class _CreateCriterionButton extends StatelessWidget {
  const _CreateCriterionButton();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45.h,
      child: FilledButton.icon(
        onPressed: () => showCreateCriterionDialog(context),
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.blue,
          foregroundColor: AppColors.white,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.r),
          ),
        ),
        icon: const Icon(Icons.add, size: 20),
        label: CustomText(
          title: 'createCriterion'.tr(),
          textStyle: Theme.of(context).textTheme.headlineLarge!.copyWith(
            color: AppColors.white,
            fontSize: 13.sp,
          ),
        ),
      ),
    );
  }
}
