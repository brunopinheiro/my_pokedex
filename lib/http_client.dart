import 'package:http/http.dart';
import 'package:rxdart/rxdart.dart';

class HttpClient {
  Client _client;

  HttpClient(Client client) {
    _client = client;
  }

  Observable get(String url) {
    return Observable
      .fromFuture(_client.get(url))
      .map((response) {
        if(response.statusCode != 200)
          throw Exception("${response.statusCode} - ${response.body}");

        return response.body;
      });
  }
}