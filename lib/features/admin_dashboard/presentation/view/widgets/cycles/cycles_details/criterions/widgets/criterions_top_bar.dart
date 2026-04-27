import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';
import 'create_criterion_dialog.dart';

class CriterionsTopBar extends StatefulWidget {
  const CriterionsTopBar({super.key});

  @override
  State<CriterionsTopBar> createState() => _CriterionsTopBarState();
}

class _CriterionsTopBarState extends State<CriterionsTopBar> {
  int? _selectedTypeId; // null means 'All Accreditations'

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 200.w,
          child: CoursesDepartmentDropDownWidget(height: 45.h),
        ),
        SizedBox(width: 12.w),
        SizedBox(
          width: 200.w,
          child: BlocBuilder<TypesCubit, TypesState>(
            builder: (context, state) {
              List<DropdownMenuItem<int?>> items = [
                DropdownMenuItem<int?>(
                  value: null,
                  child: Text('All Accreditations', style: TextStyle(fontSize: 14.sp)),
                ),
              ];

              if (state is TypesSuccess) {
                items.addAll(state.types.map((e) {
                  return DropdownMenuItem<int?>(
                    value: e.id,
                    child: Text(e.name, style: TextStyle(fontSize: 14.sp)),
                  );
                }));
              }

              return Container(
                height: 45.h,
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  border: Border.all(color: AppColors.grey.withOpacity(0.5)),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<int?>(
                    value: _selectedTypeId,
                    icon: Icon(Icons.keyboard_arrow_down, size: 20.sp),
                    style: TextStyle(
                      fontSize: 15.sp,
                      color: AppColors.mainBlack,
                    ),
                    items: items,
                    onChanged: (val) {
                      setState(() {
                        _selectedTypeId = val;
                      });
                      // Re-trigger fetch in CriterionsContent through TypesCubit if needed,
                      // or just use a local callback if we want.
                      // Since CriterionsContent listens to TypesCubit, I should probably
                      // update the Cubit or handle it differently.
                      // Actually, let's just use the existing TypesCubit.changeIndex logic
                      // but adapt it.
                      if (val != null && state is TypesSuccess) {
                        final index = state.types.indexWhere((e) => e.id == val);
                        TypesCubit.get(context).changeIndex(index);
                      } else {
                        // If 'All' is selected, we might need a way to notify TypesCubit
                        // or handle it in CriterionsContent.
                        // For now, I'll just trigger a manual fetch from here or let the listener handle it.
                        // Let's add a special state or just call changeIndex with a special value.
                        TypesCubit.get(context).changeIndex(-1); // -1 for 'All'
                      }
                    },
                  ),
                ),
              );
            },
          ),
        ),
        const Spacer(),
        const _CreateCriterionButton(),
      ],
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
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.r)),
        ),
        icon: const Icon(Icons.add, size: 20),
        label: CustomText(
          title: 'Create Criterion',
          textStyle: Theme.of(context).textTheme.headlineLarge!.copyWith(
                color: AppColors.white,
                fontSize: 13.sp,
              ),
        ),
      ),
    );
  }
}
