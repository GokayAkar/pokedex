import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokemon_api/pokemon_repo.dart';
import 'example_responses.dart';

class MockPokemonHttpHandler extends Mock implements PokemonHttpHandler {}

class MockPokemonLocalStorageHandler extends Mock implements PokemonLocalStorageHandler {}

void main() {
  group('pokemon repo', () {
    late PokemonHttpHandler pokemonHttpHandler;
    late PokemonLocalStorageHandler pokemonLocalStorageHandler;
    late PokemonRepo repo;
    late Pokemon pokemon;
    late PriorPokemonInfo pokemonInfo;

    setUp(() {
      pokemonHttpHandler = MockPokemonHttpHandler();
      pokemonLocalStorageHandler = MockPokemonLocalStorageHandler();
      repo = PokemonRepo(storageHandler: pokemonLocalStorageHandler, httpHandler: pokemonHttpHandler);
      pokemonInfo = const PriorPokemonInfo(name: 'bulbasaur', id: 1);
      pokemon = Pokemon(
        name: 'bulbasaur',
        height: 7,
        weight: 69,
        id: 1,
        imageUrl: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png',
        stats: const [
          PokemonStat(name: 'hp', value: 45),
          PokemonStat(name: 'attack', value: 45),
          PokemonStat(name: 'defence', value: 49),
          PokemonStat(name: 'special-attack', value: 65),
          PokemonStat(name: 'special-defence', value: 65),
          PokemonStat(name: 'speed', value: 45)
        ],
        types: [
          PokemonType.fromString(name: 'grass'),
          PokemonType.fromString(name: 'poison'),
        ],
      );
    });

    group('constructor', () {
      test('instantiates internal PokemonHttpHandler when not injected', () {
        expect(PokemonRepo(storageHandler: pokemonLocalStorageHandler), isNotNull);
      });
    });

    group('getPokemon', () {
      const id = 1;
      test('do not fetch if pokemon found in cache', () async {
        when(() => pokemonLocalStorageHandler.readPokemon(id)).thenAnswer((_) async => pokemon.toJson());
        await repo.getPokemon(id);
        verify(() => pokemonLocalStorageHandler.readPokemon(id)).called(1);
        verifyNever(() => pokemonHttpHandler.fetchPokemonDetail(id));
      });

      test('look to cache, fetch if null', () async {
        when(() => pokemonLocalStorageHandler.readPokemon(id)).thenAnswer((_) async => await Future.value(null));
        try {
          await repo.getPokemon(id);
        } catch (_) {}
        verify(() => pokemonLocalStorageHandler.readPokemon(id)).called(1);
        verify(() => pokemonHttpHandler.fetchPokemonDetail(id)).called(1);
      });

      test('return cached pokemon ', () async {
        when(() => pokemonLocalStorageHandler.readPokemon(id)).thenAnswer((_) async => pokemon.toJson());
        final cachedPokemon = await repo.getPokemon(id);
        expect(cachedPokemon, isA<Pokemon>());
        expect(cachedPokemon, pokemon);
      });

      test('return fetched pokemon ', () async {
        when(() => pokemonLocalStorageHandler.readPokemon(id)).thenAnswer((_) async => null);
        when(() => pokemonHttpHandler.fetchPokemonDetail(id)).thenAnswer((_) async => json.decode(fetchPokemonDetailResponse));
        final cachedPokemon = await repo.getPokemon(id);
        expect(cachedPokemon, isA<Pokemon>());
        expect(cachedPokemon, pokemon);
      });

      test('throws RequestFailed exception ', () async {
        final exception = RequestFailed();
        when(() => pokemonLocalStorageHandler.readPokemon(id)).thenAnswer((_) async => null);
        when(() => pokemonHttpHandler.fetchPokemonDetail(id)).thenThrow(exception);
        expect(() async => await repo.getPokemon(id), throwsA(exception));
      });

      test('throws PokemonNotFound exception ', () async {
        final exception = PokemonNotFound();
        when(() => pokemonLocalStorageHandler.readPokemon(id)).thenAnswer((_) async => null);
        when(() => pokemonHttpHandler.fetchPokemonDetail(id)).thenThrow(exception);
        expect(() async => await repo.getPokemon(id), throwsA(exception));
      });
    });

    group('getPokemonsToFetch', () {
      const limit = 12;
      const offset = 0;
      test('verify call', () async {
        try {
          await repo.getPokemonsToFetch(limit: limit, offset: offset);
        } catch (_) {}
        verify(() => pokemonHttpHandler.fetchPokemons(offset: offset, limit: limit)).called(1);
      });

      test('returns successfuly', () async {
        when(() => pokemonHttpHandler.fetchPokemons(limit: limit, offset: offset)).thenAnswer((_) async => json.decode(fetchPokemonsResponse));
        final response = await repo.getPokemonsToFetch(limit: limit, offset: offset);
        expect(response, isA<PokemonPaginationResponse>());
        expect(response.isLast, isNotNull);
        expect(response.pokemons.first.id, pokemonInfo.id);
        expect(response.pokemons.first.name, pokemonInfo.name);
      });

      test('throws RequestFailed exception', () async {
        final exception = RequestFailed();
        when(() => pokemonHttpHandler.fetchPokemons(limit: limit, offset: offset)).thenThrow(exception);

        expect(() async => await repo.getPokemonsToFetch(limit: limit, offset: offset), throwsA(exception));
      });
    });

    group('update favorites', () {
      test('verify call', () async {
        const favorites = [1, 2, 3];
        try {
          await repo.updateFavorites(favorites);
        } catch (_) {}

        verify(() => pokemonLocalStorageHandler.updateFavorites(favorites)).called(1);
      });

      test('updateFavorites', () async {
        const favorites = [1, 2, 3];
        when(() => pokemonLocalStorageHandler.updateFavorites(favorites)).thenAnswer((_) => true);
        final result = await repo.updateFavorites(favorites);
        expect(result, true);
      });
    });

    group('get favorites', () {
      test('verify call', () async {
        try {
          await repo.getFavoritePokemons();
        } catch (_) {}

        verify(() => pokemonLocalStorageHandler.getFavorites()).called(1);
      });

      test('getFavorites', () async {
        const favorites = [1, 2, 3];
        when(() => pokemonLocalStorageHandler.getFavorites()).thenReturn(favorites);
        final result = await repo.getFavoritePokemons();
        expect(result, favorites);
      });
    });
  });
}
