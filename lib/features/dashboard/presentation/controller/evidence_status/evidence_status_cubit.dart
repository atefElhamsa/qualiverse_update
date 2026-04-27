import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class EvidenceStatusCubit extends Cubit<EvidenceStatusState> {
  final List<ChartDataModel> data;
  EvidenceStatusCubit({required this.data}) : super(EvidenceStatusInitial());

  int get activeIndex => state is EvidenceStatusActiveIndex
      ? (state as EvidenceStatusActiveIndex).activeIndex
      : -1;

  void onSectionTouched(int index) {
    emit(EvidenceStatusActiveIndex(activeIndex: index));
  }

  void onLegendTapped(int index) {
    final newIndex = activeIndex == index ? -1 : index;
    emit(EvidenceStatusActiveIndex(activeIndex: newIndex));
  }
}
