import 'package:rxdart/rxdart.dart';

import 'package:my_pokedex/http_client.dart';

typedef HttpClientGetStub = Observable<String> Function(String);

class HttpClientStub implements HttpClient {
  HttpClientGetStub getStub;

  Observable get(String url) {
    return getStub(url);
  }
}