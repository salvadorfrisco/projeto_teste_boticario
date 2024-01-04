import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:projeto_teste/features/pokemon/presenter/pages/pokemon_page.dart';
import 'package:projeto_teste/main.dart';

void main() {
  testWidgets('App should run and display the main screen',
      (WidgetTester tester) async {
    // Wait for all asynchronous operations to complete.
    await tester.pumpAndSettle();
    // Build our app and trigger a frame.
    await tester.pumpWidget(const PokemonApp());

    // Verify if the app title is displayed.
    expect(find.text('Teste Boticário'), findsOneWidget);

    // Verify if the app bar title is displayed.
    expect(find.text('Teste Boticário'), findsOneWidget);

    // Verify if the PokemonPage widget is present.
    expect(find.byType(PokemonPage), findsOneWidget);
  });

  testWidgets('Check if the initial state is correct',
      (WidgetTester tester) async {
    await tester.pumpWidget(const PokemonApp());

    // Wait for all asynchronous operations to complete.
    await tester.pumpAndSettle();

    // Verify if the initial state is correct.

    // Example: Check if a specific widget is present.
    expect(find.byType(SafeArea), findsOneWidget);
    expect(find.byType(Scaffold), findsOneWidget);
  });

  // Add more tests as needed based on your widget tree and logic.
}
