import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/constants/constants.dart';
import '../../../pokemon_image/presenter/providers/pokemon_image_provider.dart';
import '../providers/pokemon_provider.dart';
import '../providers/selected_pokemon_item_provider.dart';

class SelectPokemonWidget extends StatelessWidget {
  const SelectPokemonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SelectedPokemonItemProvider selectedPokemonItem =
        Provider.of<SelectedPokemonItemProvider>(context);
    return Padding(
      padding: const EdgeInsets.only(
        left: 20.0,
        right: 20.0,
        bottom: 40.0,
      ),
      child: ElevatedButton(
        onPressed: () => showCupertinoModalPopup(
          context: context,
          builder: (BuildContext context) => Container(
            height: 216,
            padding: const EdgeInsets.only(top: 6.0),
            margin: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            color: CupertinoColors.systemBackground.resolveFrom(context),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  child: const Text('Fechar'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                Expanded(
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
                        PokemonImageProvider pokemonImageProvider =
                            Provider.of<PokemonImageProvider>(context,
                                listen: false);

                        Provider.of<PokemonProvider>(context, listen: false)
                            .eitherFailureOrPokemon(
                          value: (selectedPokemonItem.number + 1).toString(),
                          pokemonImageProvider: pokemonImageProvider,
                        );
                      },
                      children: List<Widget>.generate(
                        maxPokemonId,
                        (int index) {
                          return Center(
                            child: Text(
                              (index + 1).toString(),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        child: const Text(
          'Selecionar',
          style: TextStyle(
            fontSize: 22.0,
          ),
        ),
      ),
    );
  }
}
