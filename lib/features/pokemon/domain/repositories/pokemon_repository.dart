import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../core/params/params.dart';
import '../entities/pokemon_entity.dart';

abstract class IPokemonRepository {
  Future<Either<Failure, PokemonEntity>> getPokemon(
      {required PokemonParams params});

  Future<Either<Failure, List<String>>> getPokemonNames();
}
