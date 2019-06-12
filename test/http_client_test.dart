import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';

import 'package:my_pokedex/http_client.dart';

void main() {
  test("should emit response's body and then done when response is 200", (){
    final expectedUrl = 'https://expected.url.com';
    final expectedBody = json.encode('{ success: true }');

    final mockedClient = MockClient((request) async {
      return request.url.toString() != expectedUrl ? Response(null, 404) : Response(expectedBody, 200);
    });

    final httpClient = HttpClient(mockedClient);

    expect(httpClient.get(expectedUrl), emitsInOrder(<Matcher>[
      emits(equals(expectedBody)),
      emitsDone
      ]));
  });

  test('should emit error when response is not 200', () {
    final expectedUrl = "https://expected.url.com";

    final mockedClient = MockClient((request) async {
      return Response("error body", 404);
    });

    final httpClient = HttpClient(mockedClient);

    expect(httpClient.get(expectedUrl), emitsInOrder(<Matcher>[
      emitsError(isException)
      ]));
  });
}