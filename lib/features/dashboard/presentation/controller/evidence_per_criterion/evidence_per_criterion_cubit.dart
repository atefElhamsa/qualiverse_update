import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../routing/all_routes_imports.dart';

class EvidencePerCriterionCubit extends Cubit<EvidencePerCriterionState> {
  final List<CriterionDataModel> data;
  EvidencePerCriterionCubit({required this.data})
      : super(EvidencePerCriterionInitial());

  static EvidencePerCriterionCubit get(context) => BlocProvider.of(context);

  void loadData() {
    emit(EvidencePerCriterionLoaded(data: data));
  }
}
