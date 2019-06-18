import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:my_pokedex/gateway/gateway_widget.dart';
import 'package:rxdart/rxdart.dart';
import '../http_client_mock.dart';

void main() {
  testWidgets('Show loading at the beginning', (WidgetTester tester) async {
    var httpClientMock = HttpClientMock();
    httpClientMock.getMock = (_) => Observable.never();

    var materialApp = MaterialApp(
      title: "Gateway Widget Test",
      home: GatewayWidget("testUrl", httpClientMock)
    );

    await tester.pumpWidget(materialApp);
    expect(find.text('loading...'), findsOneWidget);
  });

  testWidgets("Hides loading when gateway data is loaded", (WidgetTester tester) async {
    var httpResponse = PublishSubject<String>();
    var httpClientMock = HttpClientMock();
    httpClientMock.getMock = (_) => httpResponse;

    var materialApp = MaterialApp(
      title: "Gateway Widget Test",
      home: GatewayWidget("testUrl", httpClientMock)
    );

    await tester.pumpWidget(materialApp);
    expect(find.text('loading...'), findsOneWidget);
    expect(find.text("we're done!"), findsNothing);

    httpResponse.close();
    await tester.pump();

    expect(find.text('loading...'), findsNothing);
    expect(find.text("we're done!"), findsOneWidget);
  });

  testWidgets("Shows error message when gateway data couldn't be fetched", (WidgetTester tester) async {
    var httpResponse = PublishSubject<String>();
    var httpClientMock = HttpClientMock();
    httpClientMock.getMock = (_) => httpResponse;

    var materialApp = MaterialApp(
      title: "Gateway Widget Test",
      home: GatewayWidget("testUrl", httpClientMock)
    );

    await tester.pumpWidget(materialApp);
    expect(find.text('loading...'), findsOneWidget);

    httpResponse.addError("something went wrong");
    await tester.pump();

    expect(find.text("Couldn't fetch API data. Please try again"), findsOneWidget);
    expect(find.byType(IconButton), findsOneWidget);
  });

  testWidgets("Retries fetch gateway data when replay button is pressed", (WidgetTester tester) async {
    var httpClientMock = HttpClientMock();
    httpClientMock.getMock = (_) => Observable.error("Something went wrong");

    var materialApp = MaterialApp(
      title: "Gateway Widget Test",
      home: GatewayWidget("testUrl", httpClientMock)
    );

    await tester.pumpWidget(materialApp);
    await tester.pump();

    httpClientMock.getMock = (_) => Observable.empty();
    expect(find.text("Couldn't fetch API data. Please try again"), findsOneWidget);
    expect(find.text("we're done"), findsNothing);

    await tester.tap(find.byType(IconButton));
    await tester.pump();

    expect(find.text("we're done!"), findsOneWidget);
    expect(find.text("Couldn't fetch API data. Please try again"), findsNothing);
   });
}