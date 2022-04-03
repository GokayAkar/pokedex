import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokemon/src/pokemon/pokemon_detail/cubits/pokemon_detail_cubit.dart';
import 'package:pokemon_api/pokemon_repo.dart';

class MockPokemonRepo extends Mock implements PokemonRepo {}

class MockPokemon extends Mock implements Pokemon {}

void main() {
  group('pokemon detail cubit', () {
    late PokemonRepo repo;
    late Pokemon pokemon;
    late Map<PokemonId, Pokemon> favoritePokemons;
    late PokemonId id;

    setUp(() {
      id = 1;
      repo = MockPokemonRepo();
      pokemon = MockPokemon();
      favoritePokemons = {};
      when(() => repo.getPokemon(id)).thenAnswer((_) async => pokemon);
    });

    test('initial state is correct', () {
      final cubit = PokemonDetailCubit(repo: repo, id: 1, pokedex: favoritePokemons);
      expect(cubit.state.status, equals(PokemonDetailStateStatus.loading));
      expect(cubit.state.pokemon, isNull);
    });

    group('getPokemon', () {
      blocTest<PokemonDetailCubit, PokemonDetailState>(
        'verify calls getPokemons ',
        build: () => PokemonDetailCubit(
          id: id,
          pokedex: favoritePokemons,
          repo: repo,
        ),
        act: (_) {},
        verify: (_) {
          verify(() => repo.getPokemon(id)).called(1);
        },
      );

      blocTest<PokemonDetailCubit, PokemonDetailState>(
        'verify never calls getPokemons if in memory cache includes pokemon ',
        setUp: () => favoritePokemons[id] = pokemon,
        build: () => PokemonDetailCubit(
          id: id,
          pokedex: favoritePokemons,
          repo: repo,
        ),
        act: (_) {},
        verify: (_) {
          verifyNever(() => repo.getPokemon(id));
        },
      );

      blocTest<PokemonDetailCubit, PokemonDetailState>(
        'update state to loading if state is not loading before fetch',
        seed: () => PokemonDetailState(status: PokemonDetailStateStatus.requestFailed, pokemon: pokemon),
        build: () => PokemonDetailCubit(
          id: id,
          pokedex: favoritePokemons,
          repo: repo,
        ),
        act: (cubit) {
          cubit.getPokemon();
        },
        expect: () => <PokemonDetailState>[
          const PokemonDetailState(status: PokemonDetailStateStatus.loading, pokemon: null),
          PokemonDetailState(status: PokemonDetailStateStatus.success, pokemon: pokemon),
        ],
      );
      blocTest<PokemonDetailCubit, PokemonDetailState>(
        'fetch pokemons successfully.',
        build: () => PokemonDetailCubit(
          id: id,
          pokedex: favoritePokemons,
          repo: repo,
        ),
        act: (_) {},
        expect: () => <PokemonDetailState>[
          PokemonDetailState(status: PokemonDetailStateStatus.success, pokemon: pokemon),
        ],
      );

      blocTest<PokemonDetailCubit, PokemonDetailState>(
        'throw request failed state ',
        setUp: () {
          when(() => repo.getPokemon(id)).thenThrow(const RequestFailed());
        },
        build: () => PokemonDetailCubit(
          id: id,
          pokedex: favoritePokemons,
          repo: repo,
        ),
        act: (cubit) {
          cubit.getPokemon();
        },
        expect: () => <PokemonDetailState>[
          const PokemonDetailState(status: PokemonDetailStateStatus.loading, pokemon: null),
          const PokemonDetailState(status: PokemonDetailStateStatus.requestFailed, pokemon: null),
        ],
      );

      blocTest<PokemonDetailCubit, PokemonDetailState>(
        'throw pokemon not found state ',
        setUp: () {
          when(() => repo.getPokemon(id)).thenThrow(PokemonNotFound());
        },
        build: () => PokemonDetailCubit(
          id: id,
          pokedex: favoritePokemons,
          repo: repo,
        ),
        act: (cubit) {
          cubit.getPokemon();
        },
        expect: () => <PokemonDetailState>[
          const PokemonDetailState(status: PokemonDetailStateStatus.loading, pokemon: null),
          const PokemonDetailState(status: PokemonDetailStateStatus.notFound, pokemon: null),
        ],
      );

      blocTest<PokemonDetailCubit, PokemonDetailState>(
        'throw unknown error state',
        setUp: () {
          when(() => repo.getPokemon(id)).thenThrow(Exception());
        },
        build: () => PokemonDetailCubit(
          id: id,
          pokedex: favoritePokemons,
          repo: repo,
        ),
        act: (cubit) {
          cubit.getPokemon();
        },
        expect: () => <PokemonDetailState>[
          const PokemonDetailState(status: PokemonDetailStateStatus.loading, pokemon: null),
          const PokemonDetailState(status: PokemonDetailStateStatus.unknownError, pokemon: null),
        ],
      );
    });
  });
}
