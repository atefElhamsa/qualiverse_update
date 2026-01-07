import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

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
      _handleError(e);
    }
  }

  Future<void> pickAndUploadIndicatorFile({
    required int indicatorId,
    required int criterionId,
  }) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx'],
      );

      if (result == null || result.files.single.path == null) return;

      emit(IndicatorUploadLoading(indicatorId: indicatorId));

      final file = File(result.files.single.path!);

      await IndicatorServices.uploadIndicatorFile(
        indicatorId: indicatorId,
        file: file,
      );
      await fetchIndicators(criterionId: criterionId);
    } catch (e) {
      _handleError(e);
    }
  }

  String _buildFileUrl(String filePath) {
    return "${EndPoints.baseUrlToOpenFile}/$filePath";
  }

  Future<void> openIndicatorFile(String filePath) async {
    try {
      final url = Uri.parse(_buildFileUrl(filePath));

      if (!await canLaunchUrl(url)) {
        throw Exception('Cannot open file');
      }

      await launchUrl(url, mode: LaunchMode.externalApplication);
    } catch (e) {
      emit(IndicatorsError(message: "Failed To Open File"));
    }
  }

  void reset() {
    indicators = [];
    selectedIndicator = null;
    emit(IndicatorsInitial());
  }

  void _handleError(dynamic e) async {
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
