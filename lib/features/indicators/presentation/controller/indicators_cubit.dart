import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../routing/all_routes_imports.dart';

class IndicatorsCubit extends Cubit<IndicatorsState> {
  IndicatorsCubit() : super(IndicatorsInitial());

  static IndicatorsCubit get(BuildContext context) => BlocProvider.of(context);

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

  Future<void> fetchIndicators({
    required int criterionId,
    bool silent = false,
  }) async {
    if (!silent) emit(IndicatorsLoading());

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
      if (!silent) {
        handleError(e);
      } else {
        handleActionError(e);
        if (indicators.isNotEmpty) {
          emit(
            IndicatorsSuccess(
              indicators: indicators,
              selectedIndicator: selectedIndicator,
            ),
          );
        }
      }
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
      await fetchIndicators(criterionId: criterionId, silent: true);
    } catch (e) {
      handleActionError(e);
      if (indicators.isNotEmpty) {
        emit(
          IndicatorsSuccess(
            indicators: indicators,
            selectedIndicator: selectedIndicator,
          ),
        );
      }
    }
  }

  String buildFileUrl(String filePath) {
    if (!filePath.startsWith('http')) {
      return "${EndPoints.baseUrlToOpenFile}/$filePath";
    }
    return filePath;
  }

  Future<void> openIndicatorFile(String filePath) async {
    try {
      final url = Uri.parse(buildFileUrl(filePath));

      if (!await canLaunchUrl(url)) {
        throw Exception('Cannot open file');
      }

      await launchUrl(url, mode: LaunchMode.externalApplication);
    } catch (e) {
      emit(IndicatorsError(message: "Failed To Open File"));
    }
  }

  Future<void> deleteIndicatorFile({
    required int indicatorId,
    required int criterionId,
  }) async {
    try {
      emit(FileIndicatorDeleteLoading());

      final result = await IndicatorServices.deleteIndicatorFile(
        indicatorId: indicatorId,
      ).timeout(const Duration(seconds: 30));

      emit(FileIndicatorDeleteSuccess(message: result));

      Future.delayed(const Duration(milliseconds: 300), () {
        fetchIndicators(criterionId: criterionId, silent: true);
      });
    } catch (e) {
      handleActionError(e);
      if (indicators.isNotEmpty) {
        emit(
          IndicatorsSuccess(
            indicators: indicators,
            selectedIndicator: selectedIndicator,
          ),
        );
      } else {
        emit(IndicatorsInitial());
      }
    }
  }

  void reset() {
    indicators = [];
    selectedIndicator = null;
    emit(IndicatorsInitial());
  }

  void handleError(dynamic e) async {
    final msg = e.toString();
    print(msg);

    final match = RegExp(r'description:\s*(.*?),\s*statusCode').firstMatch(msg);

    final description = match?.group(1);

    if (description != null) {
      emit(IndicatorsError(message: description));
      return;
    }

    if (msg.contains('No Internet')) {
      emit(IndicatorsError(message: "checkInternet".tr()));
      return;
    }

    if (msg.contains('Unauthorized')) {
      await LoginStorage.clear();
      reset();
      emit(IndicatorsError(message: 'Session expired, please login again'));
      return;
    }
    emit(IndicatorsError(message: 'Something went wrong'));
  }

  void handleActionError(dynamic e) async {
    final msg = e.toString().replaceFirst('Exception: ', '').trim();
    print("Action Error: $msg");

    final match = RegExp(r'description:\s*(.*?),\s*statusCode').firstMatch(msg);
    final description = match?.group(1);

    if (description != null) {
      emit(IndicatorActionError(message: description));
      return;
    }

    if (msg.contains('No Internet')) {
      emit(IndicatorActionError(message: "checkInternet".tr()));
      return;
    }

    if (msg.contains('Unauthorized')) {
      await LoginStorage.clear();
      reset();
      emit(IndicatorsError(message: 'Session expired, please login again'));
      return;
    }

    // If it's a plain string error from IndicatorsService
    emit(
      IndicatorActionError(
        message: msg.isNotEmpty ? msg : 'Something went wrong',
      ),
    );
  }
}
