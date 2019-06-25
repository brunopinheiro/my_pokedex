import 'dart:convert';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:my_pokedex/validator_http_client.dart';

void main() {
    test("should forward response's body when response is 200", () {
      final mockClient = MockClient((request) async {
        return Response(json.encode({ 'success': true }), 200);
      });
    
      final httpClient = new ValidatorHttpClient(mockClient);
      expect(httpClient.get('anything'), completion(equals(json.encode({ 'success': true }))));
  });

  test('should throw error if response status code is not 200', () {
    final mockClient = MockClient((request) async {
      return Response('error body', 403);
    });

    final httpClient = new ValidatorHttpClient(mockClient);
    expect(httpClient.get('anything'), throwsA('403 - error body'));
  });
}