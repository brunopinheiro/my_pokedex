import 'dart:convert';

import 'package:my_pokedex/http_client.dart';

class PokeApi {
  static const String kBaseUrl = 'https://pokeapi.co/api/v2';
  final HttpClient client;

  PokeApi(HttpClient client): this.client = client;

  Future<String> request(String key) {
    return client.get(kBaseUrl)
      .then((response) => json.decode(response))
      .then((gateway) {
      if(gateway.containsKey(key)) {
        return client.get(gateway[key]);
      }

      throw("404 - $key key not found");
    });
  }
}