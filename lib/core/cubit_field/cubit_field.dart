import 'package:flutter_bloc/flutter_bloc.dart';

class PasswordCubit extends Cubit<bool> {
  PasswordCubit(super.initialState);

  void toggle() => emit(!state);
}
