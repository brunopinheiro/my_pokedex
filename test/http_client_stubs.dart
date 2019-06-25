import 'package:my_pokedex/http_client.dart';

class SuccessHttpClient implements HttpClient {
  final String _response;
  SuccessHttpClient(String response): _response = response;

  Future<String> get(String url) {
    return Future.value(_response);
  }
}

class FailureHttpClient implements HttpClient {
  final String _message;
  FailureHttpClient(String message): _message = message;

  Future<String> get(String url) {
    return Future.error(_message);
  }
}


typedef HttpClientGetStub = Future<String> Function(String url);
class HttpClientStub implements HttpClient {
  HttpClientGetStub _stub;
  HttpClientStub(HttpClientGetStub stub): _stub = stub;

  Future<String> get(String url) {
    return _stub(url);
  }
}
