import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/features/admin_dashboard/data/model/assignment_indicator_admin_model.dart';
import 'package:qualiverse/features/admin_dashboard/presentation/controller/cycles/assignments/approve_reject_assignment_cubit.dart';
import 'package:qualiverse/features/admin_dashboard/presentation/controller/cycles/assignments/approve_reject_assignment_state.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../../../../routing/all_routes_imports.dart';

class AssignmentsRowWidget extends StatelessWidget {
  const AssignmentsRowWidget({
    super.key,
    required this.assignment,
    required this.index,
    required this.total,
  });

  final AssignmentIndicatorAdminModel assignment;
  final int index;
  final int total;

  @override
  Widget build(BuildContext context) {
    final isLast = index == total - 1;
    final formattedDate = assignment.deadline != null
        ? DateFormat('yyyy-MM-dd').format(assignment.deadline!)
        : '---';

    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border(
          bottom: isLast
              ? BorderSide.none
              : const BorderSide(color: AppColors.grey),
        ),
      ),
      child: Row(
        children: [
          _buildRowItem(assignment.indicatorName, 2),
          _buildRowItem(assignment.description, 4),
          _buildRowItem(assignment.doctorName, 2),
          _buildRowItem(formattedDate, 2),
          _buildStatusItem(assignment.status, 2, context),
          _buildFileItem(assignment.filePath, 1, context),
          _buildActionItem(assignment, 2, context),
        ],
      ),
    );
  }

  Widget _buildRowItem(String text, int flex) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: CustomText(
          textAlign: TextAlign.center,
          title: text,
          textStyle: TextStyle(fontSize: 14.sp, color: AppColors.mainBlack),
        ),
      ),
    );
  }

  Widget _buildStatusItem(String status, int flex, BuildContext context) {
    Color color;
    String translatedStatus = status;
    final isAr = context.locale.languageCode == 'ar';

    switch (status.toLowerCase()) {
      case 'pending':
        color = AppColors.orange;
        translatedStatus = isAr ? 'قيد الانتظار' : 'Pending';
        break;
      case 'submitted':
        color = AppColors.blue;
        translatedStatus = isAr ? 'تم التسليم' : 'Submitted';
        break;
      case 'approved':
        color = AppColors.green;
        translatedStatus = isAr ? 'مقبول' : 'Approved';
        break;
      case 'rejected':
        color = AppColors.red;
        translatedStatus = isAr ? 'مرفوض' : 'Rejected';
        break;
      default:
        color = AppColors.mainGrey;
    }

    return Expanded(
      flex: flex,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 8.w),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(6.r),
          ),
          child: Text(
            translatedStatus,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w800,
              color: AppColors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget _buildFileItem(String? filePath, int flex, BuildContext context) {
    final hasFile = filePath != null && filePath.isNotEmpty;
    return Expanded(
      flex: flex,
      child: Center(
        child: hasFile
            ? Tooltip(
                message: 'view_file'.tr(),
                child: InkWell(
                  onTap: () async {
                    String cleanPath = filePath;
                    if (cleanPath.startsWith('/')) {
                      cleanPath = cleanPath.substring(1);
                    }
                    final url = Uri.parse(
                      "${EndPoints.baseUrlToOpenFile}/$cleanPath",
                    );
                    if (await canLaunchUrl(url)) {
                      await launchUrl(
                        url,
                        mode: LaunchMode.externalApplication,
                      );
                    }
                  },
                  borderRadius: BorderRadius.circular(8.r),
                  child: Container(
                    padding: EdgeInsets.all(4.w),
                    decoration: BoxDecoration(
                      color: AppColors.progressColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Icon(
                      Icons.file_present_rounded,
                      color: AppColors.progressColor,
                      size: 20.sp,
                    ),
                  ),
                ),
              )
            : const Text('-', style: TextStyle(color: AppColors.mainGrey)),
      ),
    );
  }

  Widget _buildActionItem(
    AssignmentIndicatorAdminModel assignment,
    int flex,
    BuildContext context,
  ) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child:
            BlocBuilder<
              ApproveRejectAssignmentCubit,
              ApproveRejectAssignmentState
            >(
              builder: (context, state) {
                if (state is ApproveRejectAssignmentLoading &&
                    state.indicatorId == assignment.id) {
                  return Center(
                    child: SizedBox(
                      height: 20.h,
                      width: 20.w,
                      child: const CircularProgressIndicator(strokeWidth: 2),
                    ),
                  );
                }

                final status = assignment.status.toLowerCase();
                if (status == 'submitted' || status == 'pending') {
                  final isAr = context.locale.languageCode == 'ar';
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Tooltip(
                        message: isAr ? 'قبول' : 'Approve',
                        child: InkWell(
                          onTap: () => context
                              .read<ApproveRejectAssignmentCubit>()
                              .approveAssignment(assignment.indicatorId),
                          borderRadius: BorderRadius.circular(8.r),
                          child: Container(
                            padding: EdgeInsets.all(4.w),
                            decoration: BoxDecoration(
                              color: AppColors.green.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Icon(
                              Icons.check_rounded,
                              color: AppColors.green,
                              size: 20.sp,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Tooltip(
                        message: isAr ? 'رفض' : 'Reject',
                        child: InkWell(
                          onTap: () => context
                              .read<ApproveRejectAssignmentCubit>()
                              .rejectAssignment(assignment.indicatorId),
                          borderRadius: BorderRadius.circular(8.r),
                          child: Container(
                            padding: EdgeInsets.all(4.w),
                            decoration: BoxDecoration(
                              color: AppColors.red.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Icon(
                              Icons.close_rounded,
                              color: AppColors.red,
                              size: 20.sp,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }

                return const Center(
                  child: Text('-', style: TextStyle(color: AppColors.mainGrey)),
                );
              },
            ),
      ),
    );
  }
}
