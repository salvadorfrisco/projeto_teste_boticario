import 'package:dio/dio.dart';

import '../../../../../core/errors/exceptions.dart';
import '../../../../core/params/params.dart';
import '../models/pokemon_model.dart';

abstract class IPokemonDataSource {
  Future<PokemonModel> getPokemon({required PokemonParams params});
  Future<List<String>> getPokemonNames();
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

  @override
  Future<List<String>> getPokemonNames() async {
    final response = await dio.get(
      'https://pokeapi.co/api/v2/pokemon?limit=100000&offset=0',
    );

    if (response.statusCode == 200) {
      final List<dynamic> results = response.data['results'];

      List<String> names =
          results.map<String>((result) => result['name'].toString()).toList();
      return names;
    } else {
      throw Exception('Failed to load Pokemon data');
    }
  }
}
