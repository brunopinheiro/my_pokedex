import 'package:rxdart/rxdart.dart';

import 'package:my_pokedex/http_client.dart';

typedef HttpClientGetStub = Observable<String> Function(String);

class HttpClientStub implements HttpClient {
  HttpClientGetStub getStub;

  Observable get(String url) {
    return getStub(url);
  }
}

class NeverEndingHttpClient implements HttpClient {
  Observable get(String url) {
    return Observable.never();
  }
}

class FailingHttpClient implements HttpClient {
  Observable get(String url) {
    return Observable.error('could not fetch data from $url');
  }
}

class SuccessHttpClient implements HttpClient {
  final String _response;

  SuccessHttpClient(String response): _response = response;

  Observable get(String url) {
    return Observable.just(_response);
  }
}
