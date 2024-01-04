import 'dart:io';

import 'package:flutter/material.dart';
import 'package:projeto_teste/features/pokemon_image/domain/entities/pokemon_image_entity.dart';
import 'package:projeto_teste/features/pokemon_image/presenter/providers/pokemon_image_provider.dart';
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
    PokemonImageEntity? pokemonImageEntity =
        Provider.of<PokemonImageProvider>(context).pokemonImage;
    Failure? failure = Provider.of<PokemonImageProvider>(context).failure;
    late Widget widget;
    if (pokemonImageEntity != null) {
      widget = Expanded(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: const Color.fromARGB(255, 0, 255, 221),
            image: DecorationImage(
              image: FileImage(File(pokemonImageEntity.path)),
            ),
          ),
          child: child,
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
