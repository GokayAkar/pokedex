import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokemon/src/pokemon/favourite_pokemons/cubits/favourite_pokemons_cubit.dart';
import 'package:pokemon_api/pokemon_repo.dart';

class MockPokemonRepo extends Mock implements PokemonRepo {}

void main() {
  group('favorite pokemons cubit', () {
    late PokemonRepo repo;
    late Set<PokemonId> ids;

    setUp(() {
      repo = MockPokemonRepo();
      ids = {1, 2, 3};

      when(() => repo.getFavoritePokemons()).thenAnswer((_) async => ids);
    });

    test('initial state is correct', () {
      final cubit = FavouritePokemonsCubit(repo: repo);
      expect(cubit.state.favouritePokemons, isA<Set<PokemonId>>());
      expect(cubit.state.stateStatus, FavouritePokemonStateStatus.loading);
    });

    group('getFavorites', () {
      blocTest<FavouritePokemonsCubit, FavouritePokemonsState>(
        'verify calls getFavourites ',
        build: () => FavouritePokemonsCubit(repo: repo),
        act: (_) {},
        verify: (_) {
          verify(() => repo.getFavoritePokemons()).called(1);
        },
      );

      blocTest<FavouritePokemonsCubit, FavouritePokemonsState>(
        'change state to loading if state is loading when get favorites called ',
        seed: () => FavouritePokemonsState(favouritePokemons: ids, stateStatus: FavouritePokemonStateStatus.error),
        build: () => FavouritePokemonsCubit(repo: repo),
        act: (cubit) {
          cubit.getFavourites();
        },
        expect: () => <FavouritePokemonsState>[
          FavouritePokemonsState(
            favouritePokemons: ids,
            stateStatus: FavouritePokemonStateStatus.loading,
            stateId: 1,
          ),
          FavouritePokemonsState(
            favouritePokemons: ids,
            stateStatus: FavouritePokemonStateStatus.successful,
            stateId: 2,
          ),
          FavouritePokemonsState(
            favouritePokemons: ids,
            stateStatus: FavouritePokemonStateStatus.successful,
            stateId: 3,
          ), // this comes of because of initial getFavorites call.
        ],
        verify: (_) {
          verify(() => repo.getFavoritePokemons()).called(2);
        },
      );

      blocTest<FavouritePokemonsCubit, FavouritePokemonsState>(
        'error state ',
        setUp: () => when(() => repo.getFavoritePokemons()).thenThrow(Exception()),
        build: () => FavouritePokemonsCubit(repo: repo),
        act: (cubit) {
          cubit.getFavourites();
        },
        expect: () => <FavouritePokemonsState>[
          FavouritePokemonsState(
            favouritePokemons: ids,
            stateStatus: FavouritePokemonStateStatus.loading,
            stateId: 2,
          ),
          FavouritePokemonsState(
            favouritePokemons: ids,
            stateStatus: FavouritePokemonStateStatus.error,
            stateId: 3,
          ),
        ],
      );
    });

    group('update favorites', () {
      blocTest<FavouritePokemonsCubit, FavouritePokemonsState>(
        'verify calls updateFavorites ',
        setUp: () => when(() => repo.updateFavorites(any())).thenAnswer((_) async => true),
        build: () => FavouritePokemonsCubit(repo: repo),
        act: (cubit) {
          cubit.updateFavourites(4);
        },
        verify: (_) {
          verify(() => repo.updateFavorites({...ids, 4})).called(1);
        },
      );

      blocTest<FavouritePokemonsCubit, FavouritePokemonsState>(
        'add favorite ',
        build: () => FavouritePokemonsCubit(repo: repo),
        setUp: () => when(() => repo.updateFavorites(any())).thenAnswer((_) async => true),
        act: (cubit) {
          cubit.updateFavourites(4);
        },
        expect: () => <FavouritePokemonsState>[
          FavouritePokemonsState(
            favouritePokemons: {4, ...ids},
            stateStatus: FavouritePokemonStateStatus.loading,
            stateId: 1,
          ),
          FavouritePokemonsState(
            favouritePokemons: {4, ...ids},
            stateStatus: FavouritePokemonStateStatus.successful,
            stateId: 2,
          )
        ],
      );

      blocTest<FavouritePokemonsCubit, FavouritePokemonsState>(
        'remove favorite ',
        build: () => FavouritePokemonsCubit(repo: repo),
        setUp: () => when(() => repo.updateFavorites(any())).thenAnswer((_) async => true),
        act: (cubit) {
          cubit.updateFavourites(4);
        },
        expect: () => <FavouritePokemonsState>[
          const FavouritePokemonsState(
            favouritePokemons: {4},
            stateStatus: FavouritePokemonStateStatus.loading,
            stateId: 1,
          ),
          FavouritePokemonsState(
            favouritePokemons: {4, ...ids},
            stateStatus: FavouritePokemonStateStatus.successful,
            stateId: 2,
          ),
        ],
      );

      blocTest<FavouritePokemonsCubit, FavouritePokemonsState>(
        'remove favorite failed ',
        setUp: () => when(() => repo.updateFavorites(any())).thenAnswer((_) async => false),
        build: () => FavouritePokemonsCubit(repo: repo),
        act: (cubit) {
          cubit.updateFavourites(4);
        },
        expect: () => <FavouritePokemonsState>[
          const FavouritePokemonsState(
            favouritePokemons: {4},
            stateStatus: FavouritePokemonStateStatus.loading,
            stateId: 1,
          ),
          const FavouritePokemonsState(
            favouritePokemons: {},
            stateStatus: FavouritePokemonStateStatus.successful,
            stateId: 2,
          ),
          FavouritePokemonsState(
            favouritePokemons: ids,
            stateStatus: FavouritePokemonStateStatus.successful,
            stateId: 3,
          ),
        ],
      );
    });
  });
}
