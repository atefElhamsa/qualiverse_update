import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../routing/all_routes_imports.dart';

class TermCubit extends Cubit<TermState> {
  TermCubit() : super(TermInitial());

  static TermCubit get(BuildContext context) => BlocProvider.of(context);

  List<TermModel> terms = [];
  TermModel? selectedTerm;

  void selectTerm({TermModel? term}) {
    selectedTerm = term;
    emit(TermSuccess(terms: terms, selectedTerm: selectedTerm));
  }

  Future<void> fetchTerms() async {
    emit(TermLoading());
    try {
      final data = await TermService.getTerms();
      terms = data;
      emit(TermSuccess(terms: terms, selectedTerm: selectedTerm));
    } catch (e) {
      final msg = e.toString().replaceFirst('Exception: ', '').trim();
      if (msg.contains('No Internet')) {
        emit(TermError(message: 'Check your internet connection'));
      } else if (msg.contains('Unauthorized')) {
        await LoginStorage.clear();
        reset();
        emit(TermError(message: 'Session expired, please login again'));
      } else {
        emit(TermError(message: msg));
      }
    }
  }

  void reset() {
    terms = [];
    selectedTerm = null;
    emit(TermInitial());
  }
}
