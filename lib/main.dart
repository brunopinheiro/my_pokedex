import 'package:http/http.dart';
import "package:flutter/material.dart";

import 'package:my_pokedex/generation_widget.dart';
import 'package:my_pokedex/poke_api.dart';
import 'package:my_pokedex/validator_http_client.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext buildContext) {
    return MaterialApp(
      title: 'My Pokédex',
      theme: ThemeData(primaryColor: Colors.red),
      home: GenerationWidget(
          PokeApi(
            ValidatorHttpClient(
              Client()
            )
          )
        ) 
    );
  }
}
