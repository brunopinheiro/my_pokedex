import 'package:my_pokedex/http_client.dart';

class SuccessHttpClient implements HttpClient {
  final String _response;
  SuccessHttpClient(String response): _response = response;

  Stream<String> get(String url) {
    return Stream.fromFuture(Future.value(_response));
  }
}

class FailureHttpClient implements HttpClient {
  final String _message;
  FailureHttpClient(String message): _message = message;

  Stream<String> get(String url) {
    return Stream.fromFuture(Future.error(_message));
  }
}


typedef HttpClientGetStub = Stream<String> Function(String url);
class HttpClientStub implements HttpClient {
  HttpClientGetStub _stub;
  HttpClientStub(HttpClientGetStub stub): _stub = stub;

  Stream<String> get(String url) {
    return _stub(url);
  }
}
