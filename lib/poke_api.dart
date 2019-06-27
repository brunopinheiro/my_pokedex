import 'dart:convert';

import 'package:my_pokedex/api.dart';
import 'package:my_pokedex/http_client.dart';

class PokeApi implements Api {
  static const String kBaseUrl = 'https://pokeapi.co/api/v2';
  final HttpClient client;

  PokeApi(HttpClient client): this.client = client;

  Stream<String> request(String key) {
    return client.get(kBaseUrl)
      .map((response) => json.decode(response))
      .asyncExpand((gateway) {
      if(gateway.containsKey(key)) {
        return client.get(gateway[key]);
      }

      throw("404 - $key key not found");
    });
  }
}
