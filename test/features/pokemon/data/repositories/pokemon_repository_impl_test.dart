// ignore_for_file: prefer_const_constructors

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:projeto_teste/core/params/params.dart';
import 'package:projeto_teste/features/pokemon/data/models/pokemon_model.dart';
import 'package:projeto_teste/features/pokemon/data/datasources/pokemon_data_source.dart';
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
    expect(result, Right(tPokemonModel));
    verify(() => datasource.getPokemon(params: tPokemonParams)).called(1);
  });
}
