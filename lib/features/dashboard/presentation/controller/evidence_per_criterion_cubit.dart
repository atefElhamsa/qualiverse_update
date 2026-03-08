import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../routing/all_routes_imports.dart';

class EvidencePerCriterionCubit extends Cubit<EvidencePerCriterionState> {
  EvidencePerCriterionCubit() : super(EvidencePerCriterionInitial());

  void loadData(List<CriterionDataModel> data) {
    emit(EvidencePerCriterionLoaded(data: data));
  }
}
