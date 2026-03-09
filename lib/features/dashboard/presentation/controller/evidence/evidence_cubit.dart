import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../routing/all_routes_imports.dart';

class EvidenceCubit extends Cubit<EvidenceState> {
  EvidenceCubit() : super(EvidenceInitial()) {
    loadData();
  }

  void loadData() {
    emit(
      EvidenceLoaded(
        data: [
          EvidenceDataModel(
            criterion: 'Institutional',
            pending: 76,
            reviewed: 90,
            rejected: 80,
          ),
          EvidenceDataModel(
            criterion: 'Program',
            pending: 76,
            reviewed: 76,
            rejected: 76,
          ),
        ],
      ),
    );
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
