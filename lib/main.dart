import "package:flutter/material.dart";

const host = "https://pokeapi.co/api/v2";

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext buildContext) {
    return MaterialApp(
      title: "Pokedex",
      theme: ThemeData(primaryColor: Colors.white),
      home: Text("Hello World")
    );
  }
}