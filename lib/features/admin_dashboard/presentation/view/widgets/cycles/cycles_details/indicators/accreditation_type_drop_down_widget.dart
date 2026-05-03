import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class AccreditationTypeDropDownWidget extends StatefulWidget {
  final double? height;
  final double? width;
  final ValueChanged<int?>? onChanged;

  const AccreditationTypeDropDownWidget({
    super.key,
    this.height,
    this.width,
    this.onChanged,
  });

  @override
  State<AccreditationTypeDropDownWidget> createState() =>
      _AccreditationTypeDropDownWidgetState();
}

class _AccreditationTypeDropDownWidgetState
    extends State<AccreditationTypeDropDownWidget> {
  @override
  void initState() {
    super.initState();
    final cubit = TypesCubit.get(context);
    if (cubit.types.isEmpty) {
      cubit.fetchTypes();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TypesCubit, TypesState>(
      builder: (context, state) {
        int? currentValue;
        if (state is TypesSuccess &&
            state.selectedIndex != -1 &&
            state.selectedIndex < state.types.length) {
          currentValue = state.types[state.selectedIndex].id;
        }

        return SizedBox(
          width: widget.width ?? double.infinity,
          child: Container(
            height: widget.height ?? 45.h,
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            decoration: BoxDecoration(
              color: AppColors.white,
              border: Border.all(color: AppColors.grey.withOpacity(0.5)),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<int?>(
                value: currentValue,
                isExpanded: true,
                hint: Text(
                  'selectAccreditation'.tr(),
                  style: TextStyle(fontSize: 14.sp),
                ),
                icon: Icon(Icons.keyboard_arrow_down, size: 20.sp),
                style: TextStyle(
                  fontSize: 15.sp,
                  color: AppColors.mainBlack,
                ),
                items: [
                  if (state is TypesSuccess)
                    ...state.types.map((e) {
                      return DropdownMenuItem<int?>(
                        value: e.id,
                        child: Text(
                          e.name,
                          style: TextStyle(fontSize: 14.sp),
                        ),
                      );
                    }),
                ],
                onChanged: (val) {
                  if (val != null && state is TypesSuccess) {
                    final index = state.types.indexWhere((e) => e.id == val);
                    TypesCubit.get(context).changeIndex(index);
                  } else {
                    TypesCubit.get(context).changeIndex(-1);
                  }
                  if (widget.onChanged != null) {
                    widget.onChanged!(val);
                  }
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
