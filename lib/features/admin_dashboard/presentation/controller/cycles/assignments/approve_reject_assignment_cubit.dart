import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class ApproveRejectAssignmentCubit extends Cubit<ApproveRejectAssignmentState> {
  ApproveRejectAssignmentCubit() : super(ApproveRejectAssignmentInitial());

  static ApproveRejectAssignmentCubit get(BuildContext context) =>
      BlocProvider.of(context);

  Future<void> approveAssignment(int indicatorId) async {
    emit(ApproveRejectAssignmentLoading(indicatorId: indicatorId));
    try {
      final response =
          await AssignmentIndicatorAdminService.approveAssignmentIndicator(
            indicatorId: indicatorId,
          );
      if (response.isSuccess) {
        emit(
          ApproveRejectAssignmentSuccess(
            message: response.data ?? 'Approved successfully',
          ),
        );
      } else {
        emit(
          ApproveRejectAssignmentError(
            error: response.error?.description ?? 'Failed to approve',
          ),
        );
      }
    } catch (e) {
      emit(
        ApproveRejectAssignmentError(
          error: e.toString().replaceFirst('Exception: ', '').trim(),
        ),
      );
    }
  }

  Future<void> rejectAssignment(int indicatorId) async {
    emit(ApproveRejectAssignmentLoading(indicatorId: indicatorId));
    try {
      final response =
          await AssignmentIndicatorAdminService.rejectAssignmentIndicator(
            indicatorId: indicatorId,
          );
      if (response.isSuccess) {
        emit(
          ApproveRejectAssignmentSuccess(
            message: response.data ?? 'Rejected successfully',
          ),
        );
      } else {
        emit(
          ApproveRejectAssignmentError(
            error: response.error?.description ?? 'Failed to reject',
          ),
        );
      }
    } catch (e) {
      emit(
        ApproveRejectAssignmentError(
          error: e.toString().replaceFirst('Exception: ', '').trim(),
        ),
      );
    }
  }
}
