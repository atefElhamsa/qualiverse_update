import 'package:qualiverse/routing/all_routes_imports.dart';

sealed class EvidenceState {}

class EvidenceInitial extends EvidenceState {}

class EvidenceLoaded extends EvidenceState {
  final List<EvidenceDataModel> data;
  final bool showPending;
  final bool showReviewed;
  final bool showRejected;

  EvidenceLoaded({
    required this.data,
    this.showPending = true,
    this.showReviewed = true,
    this.showRejected = true,
  });

  EvidenceLoaded copyWith({
    List<EvidenceDataModel>? data,
    bool? showPending,
    bool? showReviewed,
    bool? showRejected,
  }) {
    return EvidenceLoaded(
      data: data ?? this.data,
      showPending: showPending ?? this.showPending,
      showReviewed: showReviewed ?? this.showReviewed,
      showRejected: showRejected ?? this.showRejected,
    );
  }
}
