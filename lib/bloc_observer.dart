import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Custom [BlocObserver] that observes all bloc and cubit instances.
class MyBlocObserver extends BlocObserver {
  /// Called whenever a [Bloc] is instantiated.
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    if (kDebugMode) {
      print("onCreate -- ${bloc.runtimeType}");
    }
  }

  /// Called whenever a [Change] occurs in any [Bloc].
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    if (kDebugMode) {
      print('onChange -- ${bloc.runtimeType}, $change');
    }
  }

  /// Called whenever an [Error] occurs in any [Bloc].
  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    if (kDebugMode) {
      print('onError -- ${bloc.runtimeType}, $error');
    }
    super.onError(bloc, error, stackTrace);
  }

  /// Called whenever a [Bloc] is closed.
  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    if (kDebugMode) {
      print('onClose -- ${bloc.runtimeType}');
    }
  }
}
