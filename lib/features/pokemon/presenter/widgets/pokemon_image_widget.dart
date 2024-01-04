import 'package:flutter/material.dart';
import 'package:projeto_teste/features/pokemon/domain/entities/pokemon_entity.dart';
import 'package:projeto_teste/features/pokemon/presenter/providers/pokemon_provider.dart';
import 'package:provider/provider.dart';

import '../../../../../core/errors/failure.dart';

class PokemonImageWidget extends StatelessWidget {
  const PokemonImageWidget({
    Key? key,
    required this.child,
  }) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    PokemonEntity? pokemonEntity =
        Provider.of<PokemonProvider>(context).pokemon;
    Failure? failure = Provider.of<PokemonProvider>(context).failure;
    late Widget widget;
    if (pokemonEntity != null) {
      widget = Expanded(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: const Color.fromARGB(255, 155, 249, 249),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Conteúdo do contêiner
              child,

              // Imagem de fundo
              Positioned.fill(
                child: Image.network(
                  pokemonEntity.sprites.other.officialArtwork.frontDefault,
                  fit: BoxFit.cover, // ou outro modo de ajuste desejado
                ),
              ),
            ],
          ),
        ),
      );
    } else if (failure != null) {
      widget = Expanded(
          child: Center(
        child: Text(
          'Error: ${failure.errorMessage}',
          style: const TextStyle(fontSize: 20),
        ),
      ));
    } else {
      widget =
          const Expanded(child: Center(child: CircularProgressIndicator()));
    }
    return widget;
  }
}
