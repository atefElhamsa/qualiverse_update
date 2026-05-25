import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class AssignmentsContent extends StatefulWidget {
  const AssignmentsContent({super.key});

  @override
  State<AssignmentsContent> createState() => _AssignmentsContentState();
}

class _AssignmentsContentState extends State<AssignmentsContent> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _fetchInitialData();
    });
  }

  void _fetchInitialData() {
    final yearId = AcademicYearCubit.get(context).selectedAcademicYear?.id;
    if (yearId != null) {
      AssignmentsCubit.get(context).fetchAssignments(academicYearId: yearId);
    }
  }

  void _refreshData() {
    final yearId = AcademicYearCubit.get(context).selectedAcademicYear?.id;
    if (yearId != null) {
      // Re-fetch with current filters if possible, or just reset to initial
      AssignmentsCubit.get(context).fetchAssignments(
        academicYearId: yearId,
        // In a real scenario, we'd store the filters in a cubit to reuse here
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<
      ApproveRejectAssignmentCubit,
      ApproveRejectAssignmentState
    >(
      listener: (context, state) {
        if (state is ApproveRejectAssignmentSuccess) {
          showSnackBar(context, state.message, AppColors.green);
          _refreshData();
        } else if (state is ApproveRejectAssignmentError) {
          showSnackBar(context, state.error, AppColors.red);
        }
      },
      child: Container(
        margin: EdgeInsetsDirectional.only(
          start: 30.w,
          end: 30.w,
          bottom: 20.h,
        ),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.mainBlack.withOpacity(0.06),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: const Column(
          children: [
            AssignmentsTopWidget(),
            SizedBox(height: 20),
            AssignmentsTable(),
          ],
        ),
      ),
    );
  }
}
