import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:my_pokedex/api.dart';
import 'package:my_pokedex/poke_list.dart';

import 'api_stubs.dart';

void main() {
  testWidgets('should show loading state while waiting for pokemon list', (WidgetTester tester) async {
    await pumpPokeList(DelayedApi(1, SuccessfulApi('ok')), tester);
    verifyLoadingState();

    // turns out that flutter will fail if is there any timer running even after destroying the tree
    // I've already added `.cancel()` during the dispose, but, this method is async, which means the
    // timer validation by flutter is going to happen first 
    await tester.pump(Duration(seconds: 4));
  });

  testWidgets('should show the error state when failed to retrieve pokemon list', (WidgetTester tester) async {
    await pumpPokeList(FailingApi('error message'), tester);
    await tester.pump();
    verifyErrorState();
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
  matchErrorWidgets(findsNothing);
}

void verifyErrorState() {
  matchLoadingWidget(findsNothing);
  matchErrorWidgets(findsOneWidget);
}

void matchLoadingWidget(Matcher matcher) => expect(find.text('Loading...'), matcher);
void matchErrorWidgets(Matcher matcher) {
  expect(find.text('Something went wrong. Please, try again'), matcher);
  expect(find.byIcon(Icons.replay), matcher);
}
