import 'dart:convert';
import 'package:http/http.dart';

class PokeApi {
  static const String kBaseUrl = 'https://pokeapi.co/api/v2';
  final Client client;

  PokeApi(Client client): this.client = client;

  Future<String> request(String key) {
    return gateway().then((gatewayData) {
      if(gatewayData.containsKey(key)) {
        return get(gatewayData[key]);
      }

      throw("404 - $key key not found");
    });
  }

  Future<Map> gateway() {
    return get(kBaseUrl).then((response) => json.decode(response));
  }

  Future<String> get(String url) {
    return client
      .get(url)
      .then((response) {
        if(response.statusCode == 200) {
          return response.body;
        }

        throw("${response.statusCode} - ${response.body}");
      });
  }
}