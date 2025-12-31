import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../routing/all_routes_imports.dart';

class TypesCubit extends Cubit<TypesState> {
  TypesCubit() : super(TypesInitial());

  static TypesCubit get(context) => BlocProvider.of(context);

  int selectedIndex = 0;
  List<TypeModel> types = [];

  void changeIndex(int index) {
    selectedIndex = index;
    emit(TypesSuccess(types: types, selectedIndex: selectedIndex));
  }

  Future<void> fetchTypes() async {
    emit(TypesLoading());
    try {
      final data = await TypesService.getTypes();
      types = data;
      emit(TypesSuccess(types: types, selectedIndex: selectedIndex));
    } catch (e) {
      final msg = e.toString();

      if (msg.contains('No Internet')) {
        emit(TypesError(message: 'Check your internet connection'));
      } else if (msg.contains('Unauthorized')) {
        reset();
      } else {
        emit(TypesError(message: 'Something went wrong'));
      }
    }
  }

  void reset() {
    selectedIndex = 0;
    types = [];
    emit(TypesInitial());
  }
}
