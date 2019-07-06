import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:my_pokedex/generation_list.dart';
import 'package:my_pokedex/generation.dart';

void main() {
  testWidgets('should show a ListTile for each pokemon of the generation', (WidgetTester tester) async {
    final generation = Generation([
      PokemonLink('sandshrew', 'test_url/sandshrew'),
      PokemonLink('pidgey', 'test_url/pidgey')
    ]);

    await pumpGenerationList(generation, tester);

    expect(find.byType(ListTile), findsNWidgets(2));
    expect(find.text('sandshrew'), findsOneWidget);
    expect(find.text('pidgey'), findsOneWidget);
  });
}

Future<void> pumpGenerationList(Generation generation, WidgetTester tester) {
  return tester.pumpWidget(
    MaterialApp(
      title: 'Generation List test',
      home: new GenerationList(generation)
    )
  );
}
