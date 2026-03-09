import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../routing/all_routes_imports.dart';

class EvidencePerCriterionCubit extends Cubit<EvidencePerCriterionState> {
  EvidencePerCriterionCubit() : super(EvidencePerCriterionInitial());

  static EvidencePerCriterionCubit get(context) => BlocProvider.of(context);

  final List<CriterionDataModel> data = [
    const CriterionDataModel(label: 'Criterion A', value: 5),
    const CriterionDataModel(label: 'Criterion B', value: 3),
    const CriterionDataModel(label: 'Criterion C', value: 8),
    const CriterionDataModel(label: 'Criterion D', value: 2),
  ];

  void loadData() {
    emit(EvidencePerCriterionLoaded(data: data));
  }
}
