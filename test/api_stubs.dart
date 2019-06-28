import 'dart:async';

import 'package:my_pokedex/api.dart';

class DelayedApi implements Api {
  final Api _baseApi;
  final int _delay;
  DelayedApi(int delay, Api api): _delay = delay, _baseApi = api;

  Stream<String> request(String resource, [String id = ""]) {
    return Stream
      .fromFuture(Future.delayed(Duration(seconds: _delay)))
      .asyncExpand((_) => _baseApi.request(resource, id));
  }
}

class SuccessfulApi implements Api {
  final String _response;
  SuccessfulApi(String response): _response = response;

  Stream<String> request(String resource, [String id = ""]) {
    return Stream.fromFuture(Future.value(_response));
  }
}

class FailingApi implements Api {
  final String _errorResponse;
  FailingApi(String errorResponse): _errorResponse = errorResponse;

  Stream<String> request(String resource, [String id = ""]) {
    return Stream.fromFuture(Future.error(_errorResponse));
  }
}

typedef StubbedApiRequest = Stream<String> Function(String resource, String id);
class StubbedApi implements Api {
  StubbedApiRequest requestStub;

  Stream<String> request(String resource, [String id = ""]) {
    return requestStub(resource, id);
  }
}