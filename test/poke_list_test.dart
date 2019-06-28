import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:my_pokedex/api.dart';
import 'package:my_pokedex/poke_list.dart';

import 'api_stubs.dart';

const String kSuccess = 'Success...';
const String kLoading = 'Loading...';
const String kError = 'Something went wrong. Please, try again';

void main() {
  testWidgets('should show loading state while waiting for pokemon list', (WidgetTester tester) async {
    await pumpPokeList(DelayedApi(1, SuccessfulApi('ok')), tester);
    verifyLoadingState();

    // turns out that flutter will fail if is there any timer running even after destroying the tree
    // I've already added `.cancel()` during the dispose, but, this method is async, which means the
    // timer validation by flutter is going to happen first 
    await tester.pump(Duration(seconds: 4));
  });

  testWidgets('should show the pokemon list after getting the response', (WidgetTester tester) async {
    await pumpPokeList(SuccessfulApi('ok'), tester);
    await tester.pump();
    verifyListState();
  });

  testWidgets('should show the error state when failed to retrieve pokemon list', (WidgetTester tester) async {
    await pumpPokeList(FailingApi('error message'), tester);
    await tester.pump();
    verifyErrorState();
  });

  testWidgets('should retry fetching pokemons when pressing retry button while on error state', (WidgetTester tester) async {
    final apiStub = new StubbedApi();
    apiStub.requestStub = (_) => Stream.fromFuture(Future.error('error message'));

    await pumpPokeList(apiStub, tester);
    await tester.pump();

    apiStub.requestStub = (_) => Future
      .delayed(Duration(seconds: 1))
      .then((_) => Future.value('success'))
      .asStream();

    await tester.tap(find.byIcon(Icons.replay));
    await tester.pump();
    verifyLoadingState();

    await tester.pump(Duration(seconds: 3));
    verifyListState();
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
  matchListWidget(findsNothing);
  matchErrorWidgets(findsNothing);
}

void verifyListState() {
  matchLoadingWidget(findsNothing);
  matchListWidget(findsOneWidget);
  matchErrorWidgets(findsNothing);
}

void verifyErrorState() {
  matchLoadingWidget(findsNothing);
  matchListWidget(findsNothing);
  matchErrorWidgets(findsOneWidget);
}

void matchLoadingWidget(Matcher matcher) => expect(find.text(kLoading), matcher);
void matchListWidget(Matcher matcher) => expect(find.text(kSuccess), matcher);
void matchErrorWidgets(Matcher matcher) => [find.text(kError), find.byIcon(Icons.replay)].forEach((r) => expect(r, matcher));
