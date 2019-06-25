import 'package:http/http.dart' as http;
import 'package:my_pokedex/http_client.dart';

class ValidatorHttpClient implements HttpClient {
  final http.Client _client;
  ValidatorHttpClient(http.Client client): _client = client;

  Future<String> get(String url) {
      return _client
        .get(url)
        .then((response) {
          if(response.statusCode == 200) {
            return response.body;
          }

          throw("${response.statusCode} - ${response.body}");
      });
  }
}
