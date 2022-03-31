import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

import 'package:pokemon_api/pokemon_repo.dart';

import 'example_responses.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockResponse extends Mock implements http.Response {}

class FakeUri extends Fake implements Uri {}

void main() {
  group('PokemonApiClient', () {
    late http.Client httpClient;
    late PokemonApiClient pokemonApiClient;

    setUpAll(() {
      registerFallbackValue(FakeUri());
    });

    setUp(() {
      httpClient = MockHttpClient();
      pokemonApiClient = PokemonApiClient(httpClient: httpClient);
    });

    group('constructor', () {
      test('does not require an httpClient', () {
        expect(PokemonApiClient(), isNotNull);
      });
    });

    group('fetchPokemons', () {
      const limit = 12;
      const offset = 0;
      test('makes correct fetchPokemon http request', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('[]');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        try {
          await pokemonApiClient.fetchPokemons(limit: limit, offset: offset);
        } catch (_) {}
        verify(
          () => httpClient.get(
            Uri.https(
              'www.pokeapi.co',
              '/api/v2/pokemon?limit=$limit&offset=$offset',
            ),
          ),
        ).called(1);
      });

      test('throws RequestFailed on non-200 response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(400);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        expect(
          () async => await pokemonApiClient.fetchPokemons(limit: limit, offset: offset),
          throwsA(isA<RequestFailed>()),
        );
      });

      test('returns Map<String,dynamic> on valid response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);

        when(() => response.body).thenReturn(
          fetchPokemonsResponse,
        );
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        final actual = await pokemonApiClient.fetchPokemons(limit: limit, offset: offset);
        expect(
            actual,
            isA<Map<String, dynamic>>()
                .having(
              (l) => l['next'],
              'next parameter',
              'https://pokeapi.co/api/v2/pokemon/?offset=12&limit=12',
            )
                .having(
              (l) => l['results'],
              'pokemon prior infos',
              [
                {"name": "bulbasaur", "url": "https://pokeapi.co/api/v2/pokemon/1/"},
                {"name": "ivysaur", "url": "https://pokeapi.co/api/v2/pokemon/2/"},
                {"name": "venusaur", "url": "https://pokeapi.co/api/v2/pokemon/3/"},
                {"name": "charmander", "url": "https://pokeapi.co/api/v2/pokemon/4/"},
                {"name": "charmeleon", "url": "https://pokeapi.co/api/v2/pokemon/5/"},
                {"name": "charizard", "url": "https://pokeapi.co/api/v2/pokemon/6/"},
                {"name": "squirtle", "url": "https://pokeapi.co/api/v2/pokemon/7/"},
                {"name": "wartortle", "url": "https://pokeapi.co/api/v2/pokemon/8/"},
                {"name": "blastoise", "url": "https://pokeapi.co/api/v2/pokemon/9/"},
                {"name": "caterpie", "url": "https://pokeapi.co/api/v2/pokemon/10/"},
                {"name": "metapod", "url": "https://pokeapi.co/api/v2/pokemon/11/"},
                {"name": "butterfree", "url": "https://pokeapi.co/api/v2/pokemon/12/"}
              ],
            ));
      });
    });

    group('fetchPokemonDetail', () {
      const id = 1;

      test('makes correct http request', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn('{}');
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        try {
          await pokemonApiClient.fetchPokemonDetail(id);
        } catch (_) {}
        verify(
          () => httpClient.get(
            Uri.https(
              'www.pokeapi.co',
              '/api/v2/pokemon/$id',
            ),
          ),
        ).called(1);
      });

      test('throws RequestFailed on non-200 response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(400);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        expect(
          () async => await pokemonApiClient.fetchPokemonDetail(id),
          throwsA(isA<RequestFailed>()),
        );
      });

      test('throws PokemonNotFound on 404 response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(404);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        expect(
          () async => await pokemonApiClient.fetchPokemonDetail(id),
          throwsA(isA<PokemonNotFound>()),
        );
      });

      test('returns Map<String,dynamic> on valid response', () async {
        final response = MockResponse();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.body).thenReturn(fetchPokemonDetailResponse);
        when(() => httpClient.get(any())).thenAnswer((_) async => response);
        final actual = await pokemonApiClient.fetchPokemonDetail(id);
        expect(
          actual,
          isA<Map<String, dynamic>>()
              .having((w) => w['id'], 'id', 1)
              .having((w) => w['weight'], 'weight', 69)
              .having((w) => w['height'], 'height', 7)
              .having(
                (w) => w['stats'],
                'stats',
                [
                  {
                    "base_stat": 45,
                    "effort": 0,
                    "stat": {"name": "hp", "url": "https://pokeapi.co/api/v2/stat/1/"}
                  },
                  {
                    "base_stat": 49,
                    "effort": 0,
                    "stat": {"name": "attack", "url": "https://pokeapi.co/api/v2/stat/2/"}
                  },
                  {
                    "base_stat": 49,
                    "effort": 0,
                    "stat": {"name": "defense", "url": "https://pokeapi.co/api/v2/stat/3/"}
                  },
                  {
                    "base_stat": 65,
                    "effort": 1,
                    "stat": {"name": "special-attack", "url": "https://pokeapi.co/api/v2/stat/4/"}
                  },
                  {
                    "base_stat": 65,
                    "effort": 0,
                    "stat": {"name": "special-defense", "url": "https://pokeapi.co/api/v2/stat/5/"}
                  },
                  {
                    "base_stat": 45,
                    "effort": 0,
                    "stat": {"name": "speed", "url": "https://pokeapi.co/api/v2/stat/6/"}
                  }
                ],
              )
              .having(
                (w) => w['types'],
                'types',
                [
                  {
                    "slot": 1,
                    "type": {"name": "grass", "url": "https://pokeapi.co/api/v2/type/12/"}
                  },
                  {
                    "slot": 2,
                    "type": {"name": "poison", "url": "https://pokeapi.co/api/v2/type/4/"}
                  }
                ],
              )
              .having((w) => w['name'], 'name', 'bulbasaur')
              .having(
                (w) => w['sprites']['other']['official-artwork']['front_default'],
                'imageUrl',
                'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png',
              ),
        );
      });
    });
  });
}
