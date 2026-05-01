import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../../../../routing/all_routes_imports.dart';
import 'create_course_dialog_widgets.dart';

class CourseFilterRow extends StatelessWidget {
  final int? selectedDeptId, selectedLevelId, selectedTermId;
  final Function(int?) onDeptChanged, onLevelChanged, onTermChanged;

  const CourseFilterRow({
    super.key,
    required this.selectedDeptId, required this.selectedLevelId, required this.selectedTermId,
    required this.onDeptChanged, required this.onLevelChanged, required this.onTermChanged,
  });

  @override
  Widget build(BuildContext context) {
    final year = AcademicYearCubit.get(context).selectedAcademicYear?.yearNumber.toString() ?? '2025';
    return Row(
      children: [
        Expanded(flex: 2, child: CoursesDepartmentDropDownWidget(height: 45.h, isExpanded: true, selectedId: selectedDeptId, useCubitSelection: false, onChanged: onDeptChanged)),
        SizedBox(width: 6.w),
        Expanded(child: LevelDropDownWidget(height: 45.h, isExpanded: true, selectedId: selectedLevelId, useCubitSelection: false, onChanged: onLevelChanged)),
        SizedBox(width: 6.w),
        Expanded(child: SemesterDropDownWidget(height: 45.h, isExpanded: true, selectedId: selectedTermId, useCubitSelection: false, onChanged: onTermChanged)),
        SizedBox(width: 12.w),
        buildAcademicYearInfo(year),
      ],
    );
  }
}
