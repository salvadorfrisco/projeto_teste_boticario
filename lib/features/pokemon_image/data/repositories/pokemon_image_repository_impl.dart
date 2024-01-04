import 'package:dartz/dartz.dart';

import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/params/params.dart';
import '../../domain/repositories/pokemon_image_repository.dart';
import '../datasources/pokemon_image_data_source.dart';
import '../models/pokemon_image_model.dart';

class PokemonImageRepositoryImpl implements IPokemonImageRepository {
  final IPokemonImageRemoteDataSource remoteDataSource;

  PokemonImageRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, PokemonImageModel>> getPokemonImage(
      {required PokemonImageParams pokemonImageParams}) async {
    try {
      PokemonImageModel remotePokemonImage = await remoteDataSource
          .getPokemonImage(pokemonImageParams: pokemonImageParams);

      return Right(remotePokemonImage);
    } on ServerException {
      return Left(ServerFailure(errorMessage: 'This is a server exception'));
    }
  }
}
