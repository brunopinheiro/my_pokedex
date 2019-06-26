import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:my_pokedex/api.dart';
import 'package:my_pokedex/poke_list.dart';

import 'api_stubs.dart';

void main() {
  testWidgets('should show loading state while waiting for pokemon list', (WidgetTester tester) async {
    await pumpPokeList(DelayedApi(1, SuccessfulApi('')), tester);
    verifyLoadingState();
  });
}

Future<void> pumpPokeList(Api api, WidgetTester tester) {
  return tester.pumpWidget(
    MaterialApp(
      title: 'PokeList test',
      home: new PokeList(api)
    )
  );
}

void verifyLoadingState() {
  matchLoadingWidget(findsOneWidget);
}

void matchLoadingWidget(Matcher matcher) => expect(find.text('Loading...'), matcher);
