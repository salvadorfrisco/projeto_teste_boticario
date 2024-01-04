import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'features/pokemon/presenter/pages/pokemon_page.dart';
import 'features/pokemon/presenter/providers/pokemon_provider.dart';
import 'features/pokemon/presenter/providers/selected_pokemon_item_provider.dart';

void main() {
  runApp(const PokemonApp());
}

class PokemonApp extends StatelessWidget {
  const PokemonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => PokemonProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SelectedPokemonItemProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Teste Boticário',
        theme: ThemeData(
            useMaterial3: true,
            primarySwatch: Colors.blue,
            appBarTheme: const AppBarTheme(
              titleTextStyle: TextStyle(
                color: Colors.black87,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            iconTheme: const IconThemeData(
              color: Colors.black87,
            )),
        home: const Home(),
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    SelectedPokemonItemProvider selectedPokemonItem =
        Provider.of<SelectedPokemonItemProvider>(context, listen: false);
    PokemonProvider pokemonProvider =
        Provider.of<PokemonProvider>(context, listen: false);

    Provider.of<PokemonProvider>(context, listen: false).eitherFailureOrPokemon(
      value: (selectedPokemonItem.number + 1).toString(),
      pokemonProvider: pokemonProvider,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: RichText(
                  text: const TextSpan(
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      TextSpan(
                        text: 'P',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 30.0,
                        ),
                      ),
                      TextSpan(
                        text: 'o',
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 30.0,
                        ),
                      ),
                      TextSpan(
                        text: 'kemon ',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: 'Boticário',
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 30.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            body: const PokemonPage()));
  }
}
