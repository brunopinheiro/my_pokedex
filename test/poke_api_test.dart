import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';

import 'package:my_pokedex/poke_api.dart';
import 'http_client_stubs.dart';

void main() {
    test('should follow gateway map to retrieve data', () {
      final httpStub = HttpClientStub((url) {
        if(url == 'https://pokeapi.co/api/v2') {
          return Stream.fromFuture(Future.value(json.encode({ 'hello': 'https://testing/helloworld/' })));
        }

        if(url == 'https://testing/helloworld/2') {
          return Stream.fromFuture(Future.value(json.encode({ 'success': true })));
        }

        return Stream.fromFuture(Future.error('failed'));
      });

      final pokeApi = new PokeApi(httpStub);
      expect(pokeApi.request('hello', '2').single, completion(equals(json.encode({ 'success': true }))));
  });

  test('should throw error with 404 message when could not find key on gateway', () {
    final httpStub = SuccessHttpClient(json.encode({}));
    final pokeApi = new PokeApi(httpStub);
    expect(pokeApi.request('hello').single, throwsA('404 - hello resource not found'));
  });
}
