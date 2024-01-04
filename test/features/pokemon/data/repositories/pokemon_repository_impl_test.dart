// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:projeto_teste/core/errors/exceptions.dart';
import 'package:projeto_teste/core/errors/failure.dart';
import 'package:projeto_teste/core/params/params.dart';
import 'package:projeto_teste/features/pokemon/data/models/pokemon_model.dart';
import 'package:projeto_teste/features/pokemon/data/datasources/pokemon_data_source.dart';
import 'package:projeto_teste/features/pokemon/data/models/sub_models.dart';
import 'package:projeto_teste/features/pokemon/data/models/sub_models.dart';
import 'package:projeto_teste/features/pokemon/data/repositories/pokemon_repository_impl.dart';

class MockPokemonDatasource extends Mock implements IPokemonDataSource {}

void main() {
  late PokemonRepositoryImpl repository;
  late IPokemonDataSource datasource;

  setUp(() {
    datasource = MockPokemonDatasource();
    repository = PokemonRepositoryImpl(dataSource: datasource);
  });

  final officialArtwork = OfficialArtworkModel(
    frontDefault:
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png',
  );

  final other = OtherModel(
    officialArtwork: officialArtwork,
  );

  final sprites = SpritesModel(
    other: other,
  );

  final type = TypeModel(
    name: 'grass',
  );

  final types = TypesModel(
    type: type,
  );

  final tPokemonModel = PokemonModel(
    name: 'Bulbasaur',
    id: 1,
    sprites: sprites,
    types: [
      types,
    ],
  );

  final tPokemonParams = PokemonParams(
    id: '1',
  );

  test('should return pokemon model when calls the datasource', () async {
    when(() => datasource.getPokemon(params: tPokemonParams))
        .thenAnswer((_) async => tPokemonModel);
    final result = await repository.getPokemon(params: tPokemonParams);

    // Imprimir o conteúdo completo do resultado
    print(result);

    // Verificar se result é um sucesso (Right)
    if (result.isRight()) {
      // Acessar os dados do PokemonModel
      final pokemonModel = result.getOrElse(
          () => null as PokemonModel); // Retorna null se houver um erro
      if (result != null) {
        print('Nome do Pokémon: ${pokemonModel.name}');
        // Adicione mais propriedades conforme necessário
      } else {
        print('Erro: Pokémon não encontrado');
      }
    } else {
      // Lidar com o erro (Left)
      final failure = result.getOrElse(() => null as PokemonModel);
      print('Erro ao obter Pokémon: $failure');
    }

    expect(result, Right(tPokemonModel));
    verify(() => datasource.getPokemon(params: tPokemonParams)).called(1);
  });

  test(
      'should return a server failure when the call to datasource is unsucessful',
      () async {
    when(() => datasource.getPokemon(params: tPokemonParams))
        .thenThrow(ServerException());
    final result = await repository.getPokemon(params: tPokemonParams);

    // Imprimir o conteúdo completo do resultado
    print(result);

    // Verificar se result é um sucesso (Right)
    if (result.isRight()) {
      // Acessar os dados do PokemonModel
      final pokemonModel = result.getOrElse(
          () => null as PokemonModel); // Retorna null se houver um erro
      if (result != null) {
        print('Nome do Pokémon: ${pokemonModel.name}');
        // Adicione mais propriedades conforme necessário
      } else {
        print('Erro: Pokémon não encontrado');
      }
    } else {
      // Lidar com o erro (Left)
      final failure = result.getOrElse(() => null as PokemonModel);
      print('Erro ao obter Pokémon: $failure');
    }

    expect(result, Left(ServerFailure(errorMessage: '')));
    verify(() => datasource.getPokemon(params: tPokemonParams)).called(1);
  });
}
