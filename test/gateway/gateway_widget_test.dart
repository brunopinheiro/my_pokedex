import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rxdart/rxdart.dart';

import 'package:my_pokedex/gateway/gateway_widget.dart';
import 'package:my_pokedex/http_client.dart';
import '../http_client_stub.dart';

void main() {
  testWidgets('should show loading state while fetching gateway data', (WidgetTester tester) async {
    await _pumpGateway(NeverEndingHttpClient(), tester);
    _verifyLoadingState();
  });

  testWidgets('should show done state when successfully fetched gateway data', (WidgetTester tester) async {
    await _pumpGateway(SuccessHttpClient('simple response'), tester);
    _verifyLoadingState();

    await tester.pump();
    _verifyDoneState();
  });

  testWidgets('should show retry state when received an error when fetching gateway data', (WidgetTester tester) async {
    await _pumpGateway(FailingHttpClient(), tester);
    await tester.pump();
    _verifyRetryState();
  });

  testWidgets('should try fetch gateway data again when pressing retry button', (WidgetTester tester) async {
    var httpClientStub = HttpClientStub();
    httpClientStub.getStub = (_) => Observable.error("Something went wrong");

    await _pumpGateway(httpClientStub, tester);
    await tester.pump();
    _verifyRetryState();

    httpClientStub.getStub = (_) => Observable.empty();
    await tester.tap(find.byType(IconButton));
    await tester.pump();
    _verifyDoneState();
  });
}

Future<void> _pumpGateway(HttpClient httpClient, WidgetTester tester) {
  var app = MaterialApp(title: 'GatewayTest', home: GatewayWidget('testUrl', httpClient));
  return tester.pumpWidget(app);
}

void _verifyLoadingState() {
  _matchLoadingWidget(findsOneWidget);
  _matchDoneWidget(findsNothing);
  _matchRetryWidgets(findsNothing);
}

void _verifyDoneState() {
  _matchLoadingWidget(findsNothing);
  _matchDoneWidget(findsOneWidget);
  _matchRetryWidgets(findsNothing);
}

void _verifyRetryState() {
  _matchLoadingWidget(findsNothing);
  _matchDoneWidget(findsNothing);
  _matchRetryWidgets(findsOneWidget);
}

void _matchLoadingWidget(Matcher matcher) => expect(find.text('loading...'), matcher);
void _matchDoneWidget(Matcher matcher) => expect(find.text("we're done!"), matcher);
void _matchRetryWidgets(Matcher matcher) {
  expect(find.text("Couldn't fetch API data. Please try again"), matcher);
  expect(find.byType(IconButton), matcher);
}
