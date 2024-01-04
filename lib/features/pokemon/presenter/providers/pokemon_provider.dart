import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:projeto_teste/features/pokemon_image/presenter/providers/pokemon_image_provider.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../core/params/params.dart';
import '../../domain/entities/pokemon_entity.dart';
import '../../domain/usecases/get_pokemon.dart';
import '../../data/datasources/pokemon_data_source.dart';
import '../../data/repositories/pokemon_repository_impl.dart';

class PokemonProvider extends ChangeNotifier {
  PokemonEntity? pokemon;
  Failure? failure;

  PokemonProvider({
    this.pokemon,
    this.failure,
  });

  void eitherFailureOrPokemon({
    required String value,
    required PokemonImageProvider pokemonImageProvider,
  }) async {
    PokemonRepositoryImpl repository = PokemonRepositoryImpl(
      dataSource: PokemonDataSourceImpl(dio: Dio()),
    );

    final failureOrPokemon = await GetPokemon(repository).call(
      params: PokemonParams(id: value),
    );

    failureOrPokemon.fold(
      (newFailure) {
        pokemon = null;
        failure = newFailure;
        notifyListeners();
      },
      (newPokemon) {
        pokemon = newPokemon;
        failure = null;
        pokemonImageProvider.eitherFailureOrPokemonImage(
            pokemonEntity: newPokemon);
        notifyListeners();
      },
    );
  }
}
