import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qualiverse/features/ai_report/data/models/ai_report_status_model.dart';
import '../../data/service/ai_report_service.dart';
import 'ai_report_status_state.dart';

class AiReportStatusCubit extends Cubit<AiReportStatusState> {
  AiReportStatusCubit() : super(AiReportStatusInitial());

  static AiReportStatusCubit of(BuildContext context) =>
      BlocProvider.of<AiReportStatusCubit>(context);

  AiReportHealthModel? health;
  AiReportProvidersModel? providers;
  String? selectedProvider;
  String? selectedCourseNature; // "practical" | "clinical" | null

  Future<bool> checkInternet() async {
    final conn = await Connectivity().checkConnectivity();
    return conn != ConnectivityResult.none;
  }

  Future<void> fetchStatus() async {
    if (!await checkInternet()) {
      emit(AiReportStatusError(errorMessage: 'No Internet Connection'));
      return;
    }

    try {
      emit(AiReportStatusLoading());

      health = await AiReportService.getHealthStatus();
      providers = await AiReportService.getProviders();
      selectedProvider = providers?.currentProvider;

      // Treat 'unknown' / empty as no selection
      if (selectedProvider == 'unknown' || selectedProvider?.isEmpty == true) {
        selectedProvider = null;
      }

      emit(
        AiReportStatusLoaded(
          health: health!,
          providers: providers!,
          selectedProvider: selectedProvider,
          selectedCourseNature: selectedCourseNature,
        ),
      );
    } catch (e) {
      emit(
        AiReportStatusError(
          errorMessage: e.toString().replaceFirst('Exception: ', '').trim(),
        ),
      );
    }
  }

  void selectProvider(String name) {
    if (providers == null) return;
    final matchedKey = providers!.providers.keys.firstWhere(
      (key) => key.toLowerCase() == name.toLowerCase(),
      orElse: () => '',
    );

    if (matchedKey.isNotEmpty) {
      final config = providers!.providers[matchedKey];
      if (config != null && config.configured) {
        selectedProvider = matchedKey;
        _emitLoaded();
      }
    }
  }

  void selectCourseNature(String? value) {
    selectedCourseNature = value;
    _emitLoaded();
  }

  void _emitLoaded() {
    if (health != null && providers != null) {
      emit(
        AiReportStatusLoaded(
          health: health!,
          providers: providers!,
          selectedProvider: selectedProvider,
          selectedCourseNature: selectedCourseNature,
        ),
      );
    }
  }
}
