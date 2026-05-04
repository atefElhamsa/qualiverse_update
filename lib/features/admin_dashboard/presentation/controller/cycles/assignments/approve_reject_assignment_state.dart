abstract class ApproveRejectAssignmentState {}

class ApproveRejectAssignmentInitial extends ApproveRejectAssignmentState {}

class ApproveRejectAssignmentLoading extends ApproveRejectAssignmentState {
  final int indicatorId;
  ApproveRejectAssignmentLoading({required this.indicatorId});
}

class ApproveRejectAssignmentSuccess extends ApproveRejectAssignmentState {
  final String message;
  ApproveRejectAssignmentSuccess({required this.message});
}

class ApproveRejectAssignmentError extends ApproveRejectAssignmentState {
  final String error;
  ApproveRejectAssignmentError({required this.error});
}
