import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../routing/all_routes_imports.dart';

class MonthlyChartCubit extends Cubit<MonthlyChartState> {
  final List<MonthlyChartDataModel> data;

  MonthlyChartCubit({required this.data}) : super(MonthlyChartInitial()) {
    loadData();
  }

  static MonthlyChartCubit get(context) => BlocProvider.of(context);

  static const months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  static const values = [28, 10, 22, 8, 14, 20, 35, 30, 26, 6, 18, 32];

  void loadData() {
    emit(MonthlyChartLoading());
    try {
      emit(MonthlyChartLoaded(data));
    } catch (e) {
      emit(MonthlyChartError(e.toString()));
    }
  }
}
