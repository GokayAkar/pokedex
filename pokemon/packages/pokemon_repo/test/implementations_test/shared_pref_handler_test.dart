import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokemon_api/pokemon_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  final Pokemon pokemon = Pokemon(
    id: 1,
    name: 'clefairy',
    types: const [
      Fire(),
      Water(),
      UnknownType(name: 'random'),
    ],
    imageUrl: 'exampleUrl',
    height: 10,
    weight: 100,
    stats: const [
      PokemonStat(name: 'hp', value: 20),
      PokemonStat(name: 'attack', value: 30),
      PokemonStat(name: 'defence', value: 40),
      PokemonStat(name: 'special_attack', value: 50),
      PokemonStat(name: 'special_defence', value: 60),
      PokemonStat(name: 'speed', value: 70),
    ],
  );
  Map<String, dynamic> pokemonJson = pokemon.toJson();
  Set<PokemonId> favorites = {1, 2, 3};
  late SharedPreferencesCacheHandler handler;
  late SharedPreferences pref;

  setUpAll(() {
    pref = MockSharedPreferences();
    handler = SharedPreferencesCacheHandler(prefs: pref);
  });

  group('constructor', () {
    test('works properly', () {
      expect(handler, isNotNull);
    });
  });

  group('favorites', () {
    test('get favorites succesfully ', () async {
      when(() => pref.getStringList(any())).thenReturn(favorites.map((e) => e.toString()).toList());
      final _favorites = handler.getFavorites();
      expect(_favorites, equals(favorites));
      verify(
        () => pref.getStringList(SharedPreferencesCacheHandler.favoritesKey),
      ).called(1);
    });

    test('get favorites while there is not any entry ', () async {
      when(() => pref.getStringList(any())).thenThrow(Exception());
      final _favorites = handler.getFavorites();
      expect(_favorites, isEmpty);
      verify(
        () => pref.getStringList(SharedPreferencesCacheHandler.favoritesKey),
      ).called(1);
    });

    test('update favorites', () async {
      final updatedFavorites = Set<PokemonId>.from(favorites)..add(4);
      final updatedFavoritesStringList = updatedFavorites.map((e) => e.toString()).toList();
      when(() => pref.setStringList(SharedPreferencesCacheHandler.favoritesKey, updatedFavoritesStringList)).thenAnswer(
        (_) async => true,
      );
      expect(handler.updateFavorites(updatedFavorites), completes);

      verify(
        () => pref.setStringList(SharedPreferencesCacheHandler.favoritesKey, updatedFavoritesStringList),
      ).called(1);
    });
  });

  group('pokemon', () {
    test('read pokemon successfully', () {
      when(() => pref.getString(any())).thenReturn(json.encode(pokemonJson));
      when(() => pref.containsKey(any())).thenReturn(true);
      final _pokemon = handler.readPokemon(1);
      expect(_pokemon, equals(pokemonJson));
      verify(
        () => pref.getString('1'),
      ).called(1);
    });

    test('read unexisting pokemon', () {
      when(() => pref.getString(any())).thenReturn(json.encode(pokemonJson));
      when(() => pref.containsKey(any())).thenReturn(false);
      final _pokemon = handler.readPokemon(1);
      expect(_pokemon, isNull);
      verifyNever(
        () => pref.getString('1'),
      );
    });

    test('error occured while reading pokemon', () {
      when(() => pref.getString(any())).thenThrow(Exception());
      when(() => pref.containsKey(any())).thenReturn(true);
      final _pokemon = handler.readPokemon(1);
      expect(_pokemon, isNull);
      verify(
        () => pref.getString('1'),
      ).called(1);
    });

    test('save pokemon', () async {
      when(() => pref.setString(pokemon.id.toString(), json.encode(pokemon.toJson()))).thenAnswer(
        (_) async => true,
      );
      expect(handler.savePokemon(pokemon), completes);

      verify(
        () => pref.setString(pokemon.id.toString(), json.encode(pokemon.toJson())),
      ).called(1);
    });
  });
}
