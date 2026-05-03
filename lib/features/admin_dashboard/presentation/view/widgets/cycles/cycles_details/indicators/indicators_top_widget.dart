import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/features/admin_dashboard/presentation/view/widgets/cycles/cycles_details/indicators/accreditation_type_drop_down_widget.dart';

import '../../../../../../../../routing/all_routes_imports.dart';

class IndicatorsTopWidget extends StatelessWidget {
  const IndicatorsTopWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TypesCubit, TypesState>(
      builder: (context, state) {
        bool isInstitutional = false;
        if (state is TypesSuccess && state.selectedIndex != -1) {
          final selectedType = state.types[state.selectedIndex];
          if (selectedType.name.toLowerCase().contains('institutional')) {
            isInstitutional = true;
          }
        }

        return Row(
          children: [
            const Expanded(
              flex: 2,
              child: AccreditationTypeDropDownWidget(),
            ),
            SizedBox(width: 10.w),
            Expanded(
              flex: 3,
              child: DepartmentDropDownWidget(isDisabled: isInstitutional),
            ),
            SizedBox(width: 10.w),
            const Expanded(
              flex: 7,
              child: CriterionsDropDownWidget(),
            ),
          ],
        );
      },
    );
  }
}
