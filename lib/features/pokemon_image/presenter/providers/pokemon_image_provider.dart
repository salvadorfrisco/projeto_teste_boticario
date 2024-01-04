import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:projeto_teste/features/pokemon/domain/entities/pokemon_entity.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/params/params.dart';
import '../../domain/entities/pokemon_image_entity.dart';
import '../../domain/usecases/get_pokemon_image.dart';
import '../../data/datasources/pokemon_image_data_source.dart';
import '../../data/repositories/pokemon_image_repository_impl.dart';

class PokemonImageProvider extends ChangeNotifier {
  PokemonImageEntity? pokemonImage;
  Failure? failure;

  PokemonImageProvider({
    this.pokemonImage,
    this.failure,
  });

  void eitherFailureOrPokemonImage(
      {required PokemonEntity pokemonEntity}) async {
    PokemonImageRepositoryImpl repository = PokemonImageRepositoryImpl(
      remoteDataSource: PokemonImageRemoteDataSourceImpl(
        dio: Dio(),
      ),
    );

    final failureOrPokemonImage =
        await GetPokemonImage(pokemonImageRepository: repository).call(
      pokemonImageParams: PokemonImageParams(
        name: pokemonEntity.name,
        imageUrl: pokemonEntity.sprites.other.officialArtwork.frontDefault,
      ),
    );

    failureOrPokemonImage.fold(
      (Failure newFailure) {
        pokemonImage = null;
        failure = newFailure;
        notifyListeners();
      },
      (PokemonImageEntity newPokemonImage) {
        pokemonImage = newPokemonImage;
        failure = null;
        notifyListeners();
      },
    );
  }
}
