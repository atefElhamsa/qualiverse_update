import 'package:flutter/material.dart';
import 'package:qualiverse/features/all_features_imports/all_features_imports.dart';

class CoursesMainScreen extends StatefulWidget {
  const CoursesMainScreen({super.key});

  @override
  State<CoursesMainScreen> createState() => _CoursesMainScreenState();
}

class _CoursesMainScreenState extends State<CoursesMainScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        final academicYearCubit = AcademicYearCubit.get(context);
        if (academicYearCubit.academicYears.isNotEmpty) {
          academicYearCubit.selectAcademicYear(
            academicYear: academicYearCubit.academicYears.first,
          );
        }
        final levelCubit = LevelCubit.get(context);
        LevelModel? firstLevel;
        if (levelCubit.levels.isNotEmpty) {
          firstLevel = levelCubit.levels.first;
          levelCubit.selectLevel(level: firstLevel);
        }
        final deptCubit = DepartmentCubit.get(context);
        if (deptCubit.departments.isNotEmpty) {
          if (firstLevel != null && firstLevel.levelNumber <= 2) {
            deptCubit.selectDepartment(department: null);
          } else {
            deptCubit.selectDepartment(
              department: deptCubit.departments.first,
            );
          }
        }
        final termCubit = TermCubit.get(context);
        if (termCubit.terms.isNotEmpty) {
          termCubit.selectTerm(term: termCubit.terms.first);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const MainWrapper(child: CoursesMainBody());
  }
}
