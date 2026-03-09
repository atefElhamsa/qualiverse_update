import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class EvidenceStatusCubit extends Cubit<EvidenceStatusState> {
  EvidenceStatusCubit() : super(EvidenceStatusInitial());

  static EvidenceStatusCubit get(context) => BlocProvider.of(context);

  final List<ChartDataModel> data = const [
    ChartDataModel(label: 'Reviewed', value: 1, color: AppColors.reviewedColor),
    ChartDataModel(label: 'Approved', value: 1, color: AppColors.approvedColor),
    ChartDataModel(label: 'Rejected', value: 1, color: AppColors.rejectedColor),
    ChartDataModel(label: 'Pending', value: 1, color: AppColors.pendingColor),
  ];

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
