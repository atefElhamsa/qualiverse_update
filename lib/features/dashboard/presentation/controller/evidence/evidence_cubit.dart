import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../routing/all_routes_imports.dart';

class EvidenceCubit extends Cubit<EvidenceState> {
  final List<EvidenceDataModel> data;
  EvidenceCubit({required this.data}) : super(EvidenceInitial());

  void loadData() {
    emit(EvidenceLoaded(data: data));
  }

  void togglePending() {
    final current = state;
    if (current is EvidenceLoaded) {
      emit(current.copyWith(showPending: !current.showPending));
    }
  }

  void toggleReviewed() {
    final current = state;
    if (current is EvidenceLoaded) {
      emit(current.copyWith(showReviewed: !current.showReviewed));
    }
  }

  void toggleRejected() {
    final current = state;
    if (current is EvidenceLoaded) {
      emit(current.copyWith(showRejected: !current.showRejected));
    }
  }
}
