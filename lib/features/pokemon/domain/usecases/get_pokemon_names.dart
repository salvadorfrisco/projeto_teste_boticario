import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failure.dart';
import '../repositories/pokemon_repository.dart';

class GetPokemonNames {
  final IPokemonRepository repository;

  GetPokemonNames(this.repository);

  Future<Either<Failure, List<String>>> getPokemonNames() async {
    return await repository.getPokemonNames();
  }
}
