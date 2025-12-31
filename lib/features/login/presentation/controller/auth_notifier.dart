import 'dart:async';

class AuthNotifier {
  static final sessionExpired = StreamController<void>.broadcast();
}
