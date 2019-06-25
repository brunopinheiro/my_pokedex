import 'dart:convert';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:my_pokedex/poke_api.dart';

void main() {
    test("should forward response's body when response is 200", () {
      final mockClient = MockClient((request) async {
        final url = request.url.toString();
        if(url == 'https://pokeapi.co/api/v2') {
          return Response(json.encode({ 'hello': 'https://testing/helloworld' }), 200);
        }
      
        if(url == 'https://testing/helloworld') {
          return Response(json.encode({ 'success': true }), 200);
        }

        return Response(json.encode({ 'success': false }), 500);
      });
    
      final pokeApi = new PokeApi(mockClient);
      expect(pokeApi.request('hello'), completion(equals(json.encode({ 'success': true }))));
  });

  test('should throw error if response status code is not 200', () {
    final mockClient = MockClient((request) async {
      return Response('error body', 403);
    });

    final pokeApi = new PokeApi(mockClient);
    expect(pokeApi.request('hello'), throwsA('403 - error body'));
  });

  test('should throw error with 404 message when could not find key on gateway', () {
    final mockClient = MockClient((request) async {
      return Response(json.encode({}), 200);
    });

    final pokeApi = new PokeApi(mockClient);
    expect(pokeApi.request('hello'), throwsA('404 - hello key not found'));
  });
}