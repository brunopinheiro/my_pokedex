import 'dart:convert';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:my_pokedex/poke_api.dart';
import 'http_client_stubs.dart';

void main() {
    test('should follow gateway map to retrieve data', () {
      final httpStub = HttpClientStub((url) async {
        if(url == 'https://pokeapi.co/api/v2') {
          return json.encode({ 'hello': 'https://testing/helloworld' });
        }

        if(url == 'https://testing/helloworld') {
          return json.encode({ 'success': true });
        }

        throw('failed');
      });

      final pokeApi = new PokeApi(httpStub);
      expect(pokeApi.request('hello'), completion(equals(json.encode({ 'success': true }))));
  });

  test('should throw error with 404 message when could not find key on gateway', () {
    final httpStub = SuccessHttpClient(json.encode({}));
    final pokeApi = new PokeApi(httpStub);
    expect(pokeApi.request('hello'), throwsA('404 - hello key not found'));
  });
}
