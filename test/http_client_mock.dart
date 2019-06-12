import 'package:rxdart/rxdart.dart';

import 'package:my_pokedex/http_client.dart';

typedef HttpClientGetMock = Observable<String> Function(String);

class HttpClientMock implements HttpClient {
  HttpClientGetMock getMock;

  Observable get(String url) {
    return getMock(url);
  }
}