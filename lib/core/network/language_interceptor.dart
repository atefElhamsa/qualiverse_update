import 'package:dio/dio.dart';

import '../../routing/all_routes_imports.dart';

class LanguageInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final lang = CashHelper.getData(key: KeysTexts.lang) ?? 'en';
    options.headers['Accept-Language'] = lang;
    handler.next(options);
  }
}
