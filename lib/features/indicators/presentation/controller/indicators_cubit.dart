import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../routing/all_routes_imports.dart';

class IndicatorsCubit extends Cubit<IndicatorsState> {
  IndicatorsCubit() : super(IndicatorsInitial());

  static IndicatorsCubit get(context) => BlocProvider.of(context);

  List<IndicatorModel> indicators = [];
  IndicatorModel? selectedIndicator;

  void selectIndicator({required IndicatorModel indicator}) {
    selectedIndicator = indicator;

    emit(
      IndicatorsSuccess(
        indicators: indicators,
        selectedIndicator: selectedIndicator,
      ),
    );
  }

  Future<void> fetchIndicators({required int criterionId}) async {
    emit(IndicatorsLoading());

    try {
      final data = await IndicatorServices.getIndicators(
        criterionId: criterionId,
      );

      indicators = data;

      emit(
        IndicatorsSuccess(
          indicators: indicators,
          selectedIndicator: selectedIndicator,
        ),
      );
    } catch (e) {
      final msg = e.toString();

      if (msg.contains('No Internet')) {
        emit(IndicatorsError(message: "checkInternet".tr()));
      } else if (msg.contains('Unauthorized')) {
        await LoginStorage.clear();
        reset();
        emit(IndicatorsError(message: 'Session expired, please login again'));
      } else {
        emit(IndicatorsError(message: 'Something went wrong'));
      }
    }
  }

  void reset() {
    indicators = [];
    selectedIndicator = null;
    emit(IndicatorsInitial());
  }
}
