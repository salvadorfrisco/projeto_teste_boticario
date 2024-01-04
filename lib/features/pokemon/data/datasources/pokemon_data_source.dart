import 'package:dio/dio.dart';

import '../../../../../core/errors/exceptions.dart';
import '../../../../core/params/params.dart';
import '../models/pokemon_model.dart';

abstract class IPokemonDataSource {
  Future<PokemonModel> getPokemon({required PokemonParams params});
}

class PokemonDataSourceImpl implements IPokemonDataSource {
  final Dio dio;

  PokemonDataSourceImpl({required this.dio});

  @override
  Future<PokemonModel> getPokemon({required PokemonParams params}) async {
    final response = await dio.get(
      'https://pokeapi.co/api/v2/pokemon/${params.id}',
    );

    if (response.statusCode == 200) {
      return PokemonModel.fromJson(response.data);
    } else {
      throw ServerException();
    }
  }
}
