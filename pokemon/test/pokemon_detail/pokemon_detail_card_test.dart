import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokemon/src/constants/constants.dart';
import 'package:pokemon/src/pokemon/intro/intro.dart';
import 'package:pokemon/src/pokemon/pokemon_detail/pokemon_detail.dart';
import 'package:pokemon_api/pokemon_repo.dart';
import 'package:mocktail/mocktail.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MockPokemonDetailCubit extends MockCubit<PokemonDetailState> implements PokemonDetailCubit {}

class MockPokemonRepo extends Mock implements PokemonRepo {}

void main() {
  group('pokemon card widget test', () {
    late PokemonRepo repo;
    late Map<PokemonId, Pokemon> favoriteCache;
    late Pokemon pokemon;

    setUp(() {
      repo = MockPokemonRepo();
      favoriteCache = {};

      pokemon = Pokemon(
        id: 1,
        name: 'Clefairy',
        types: const [
          Fire(),
          Water(),
          UnknownType(name: 'Random'),
        ],
        imageUrl: 'exampleUrl',
        height: 10,
        weight: 100,
        stats: const [
          PokemonStat(name: 'Hp', value: 20),
          PokemonStat(name: 'Attack', value: 30),
          PokemonStat(name: 'Defence', value: 40),
          PokemonStat(name: 'Special_attack', value: 50),
          PokemonStat(name: 'Special_defence', value: 60),
          PokemonStat(name: 'Speed', value: 70),
        ],
      );

      when(() => repo.getPokemon(1)).thenAnswer((_) async => pokemon);
    });

    Widget getMaterialApp(Widget child) {
      return ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: () {
          return MaterialApp(
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en', ''),
            ],
            builder: (context, child) {
              ScreenUtil.setContext(context);
              FontSizes.initProportionedFontSizes();
              return child!;
            },
            home: child,
          );
        },
      );
    }

    testWidgets('renders PokemonDetailCardView', (tester) async {
      await tester.pumpWidget(
        getMaterialApp(
          MultiRepositoryProvider(
            providers: [
              RepositoryProvider.value(
                value: repo,
              ),
              RepositoryProvider.value(
                value: favoriteCache,
              ),
            ],
            child: const PokemonDetailCard(
              id: 1,
              isFavourite: false,
            ),
          ),
        ),
      );
      expect(find.byType(PokemonDetailCardView), findsOneWidget);
    });

    group('PokemonCardView', () {
      late PokemonDetailCubit pokemonDetailCubit;
      setUp(() {
        pokemonDetailCubit = MockPokemonDetailCubit();
      });
      testWidgets('pokemon card loading status', (tester) async {
        when(() => pokemonDetailCubit.state).thenReturn(PokemonDetailState(status: PokemonDetailStateStatus.loading, pokemon: pokemon));
        await tester.pumpAndSettle();
        await tester.pumpWidget(
          getMaterialApp(
            BlocProvider.value(
              value: pokemonDetailCubit,
              child: const PokemonDetailCardView(),
            ),
          ),
        );
        expect(find.byType(LoadingWidget), findsOneWidget);
      });
      testWidgets('pokemon card success status', (tester) async {
        when(() => pokemonDetailCubit.state).thenReturn(PokemonDetailState(status: PokemonDetailStateStatus.success, pokemon: pokemon));
        await tester.pumpWidget(
          getMaterialApp(
            BlocProvider.value(
              value: pokemonDetailCubit,
              child: const PokemonDetailCardView(),
            ),
          ),
        );
        expect(find.byType(PokemonDetailCardUI), findsOneWidget);
      });

      testWidgets('pokemon card error unknown status', (tester) async {
        when(() => pokemonDetailCubit.state).thenReturn(PokemonDetailState(status: PokemonDetailStateStatus.unknownError, pokemon: pokemon));
        await tester.pumpWidget(
          getMaterialApp(
            BlocProvider.value(
              value: pokemonDetailCubit,
              child: const Scaffold(body: PokemonDetailCardView()),
            ),
          ),
        );
        expect(find.byType(PokemonErrorCard), findsOneWidget);
        expect(find.text('Unexpected Error'), findsOneWidget);
      });

      testWidgets('pokemon card error unknown status', (tester) async {
        when(() => pokemonDetailCubit.state).thenReturn(PokemonDetailState(status: PokemonDetailStateStatus.requestFailed, pokemon: pokemon));
        await tester.pumpWidget(
          getMaterialApp(
            BlocProvider.value(
              value: pokemonDetailCubit,
              child: const Scaffold(body: PokemonDetailCardView()),
            ),
          ),
        );
        expect(find.byType(PokemonErrorCard), findsOneWidget);
        expect(find.text('Server Error'), findsOneWidget);
      });

      testWidgets('pokemon card error unknown status', (tester) async {
        when(() => pokemonDetailCubit.state).thenReturn(PokemonDetailState(status: PokemonDetailStateStatus.notFound, pokemon: pokemon));
        await tester.pumpWidget(
          getMaterialApp(
            BlocProvider.value(
              value: pokemonDetailCubit,
              child: const Scaffold(body: PokemonDetailCardView()),
            ),
          ),
        );
        expect(find.byType(PokemonErrorCard), findsOneWidget);
        expect(find.text('Pokemon Not Found'), findsOneWidget);
      });
    });
  });
}
