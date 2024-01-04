import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projeto_teste/features/pokemon/data/datasources/pokemon_data_source.dart';
import 'package:projeto_teste/features/pokemon/data/repositories/pokemon_repository_impl.dart';
import 'package:projeto_teste/features/pokemon/domain/entities/pokemon_entity.dart';
import 'package:provider/provider.dart';

import '../../../../../core/constants/constants.dart';
import '../providers/pokemon_provider.dart';
import '../providers/selected_pokemon_item_provider.dart';

class SelectPokemonWidget extends StatefulWidget {
  const SelectPokemonWidget({Key? key}) : super(key: key);

  @override
  State<SelectPokemonWidget> createState() => _SelectPokemonWidgetState();
}

class _SelectPokemonWidgetState extends State<SelectPokemonWidget> {
  List<String> names = [];
  PokemonRepositoryImpl pokemonRepositoryImpl = PokemonRepositoryImpl(
    dataSource: PokemonDataSourceImpl(dio: Dio()),
  );

  @override
  void initState() {
    super.initState();
    loadPokemonNames();
  }

  Future<void> loadPokemonNames() async {
    try {
      final failureOrNames = await pokemonRepositoryImpl.getPokemonNames();

      failureOrNames.fold(
        (failure) {
          names = [];
          failure = failure;
        },
        (namesList) {
          names = namesList;
        },
      );
    } catch (e) {
      (failure) {
        names = [];
        failure = e;
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    SelectedPokemonItemProvider selectedPokemonItem =
        Provider.of<SelectedPokemonItemProvider>(context);
    PokemonEntity? pokemon = Provider.of<PokemonProvider>(context).pokemon;
    return Padding(
      padding: const EdgeInsets.only(
        left: 20.0,
        right: 20.0,
        bottom: 40.0,
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 175, 132, 246),
          maximumSize: const Size(260, 140),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                pokemon != null ? pokemon.name.toUpperCase() : 'Selecionar',
                style: const TextStyle(
                  fontSize: 22.0,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                width: 6,
              ),
              const Icon(
                Icons.change_circle,
                size: 36.0,
                color: Colors.white,
              ),
            ],
          ),
        ),
        onPressed: () => showCupertinoModalPopup(
          context: context,
          builder: (BuildContext context) => Container(
            height: 206,
            margin: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            color: CupertinoColors.systemBackground.resolveFrom(context),
            child: SafeArea(
              top: false,
              child: CupertinoPicker(
                magnification: 1.22,
                squeeze: 1.2,
                useMagnifier: true,
                itemExtent: 32.0,
                scrollController: FixedExtentScrollController(
                  initialItem: selectedPokemonItem.number,
                ),
                onSelectedItemChanged: (int selectedItem) {
                  selectedPokemonItem.changeNumber(
                    newNumber: selectedItem,
                  );
                  PokemonProvider pokemonProvider =
                      Provider.of<PokemonProvider>(context, listen: false);

                  Provider.of<PokemonProvider>(context, listen: false)
                      .eitherFailureOrPokemon(
                    value: (selectedPokemonItem.number + 1).toString(),
                    pokemonProvider: pokemonProvider,
                  );
                },
                children: List<Widget>.generate(
                  maxPokemonId,
                  (int index) {
                    return Center(
                      child: Text(
                        names[index].toUpperCase(),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
