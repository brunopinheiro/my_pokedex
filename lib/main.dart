import 'package:http/http.dart';
import "package:flutter/material.dart";
import 'package:my_pokedex/http_client.dart';

import 'gateway/gateway_widget.dart';

const host = "https://pokeapi.co/api/v2";

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext buildContext) {
    return MaterialApp(
      title: "Pokedex",
      theme: ThemeData(primaryColor: Colors.white),
      home: GatewayWidget(
        host,
        HttpClient(Client())
      )
    );
  }
}