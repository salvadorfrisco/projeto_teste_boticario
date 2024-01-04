import 'package:dartz/dartz.dart';

import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../core/params/params.dart';
import '../../domain/repositories/pokemon_repository.dart';
import '../datasources/pokemon_data_source.dart';
import '../models/pokemon_model.dart';

class PokemonRepositoryImpl implements IPokemonRepository {
  final IPokemonDataSource dataSource;

  PokemonRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, PokemonModel>> getPokemon(
      {required PokemonParams params}) async {
    try {
      final remotePokemon = await dataSource.getPokemon(params: params);

      return Right(remotePokemon);
    } on ServerException {
      return Left(ServerFailure(errorMessage: 'This is a server exception'));
    }
  }
}
