import 'dart:async';
import 'package:dio/dio.dart';

class QueuedRequest {
  final RequestOptions options;
  final Completer<Response> completer;

  QueuedRequest(this.options, this.completer);
}
