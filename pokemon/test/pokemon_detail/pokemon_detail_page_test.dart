import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokemon/src/constants/font_sizes.dart';
import 'package:pokemon/src/pokemon/favourite_pokemons/cubits/favourite_pokemons_cubit.dart';
import 'package:pokemon/src/pokemon/pokemon_detail/pokemon_detail.dart';
import 'package:pokemon_api/pokemon_repo.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mocktail/mocktail.dart';

class MockPokemonRepo extends Mock implements PokemonRepo {}

void main() {
  group('pokemon detail page', () {
    late Pokemon pokemon;
    late PokemonRepo repo;

    setUp(() {
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
      repo = MockPokemonRepo();
      when(() => repo.getFavoritePokemons()).thenAnswer((_) async => {2, 3, 4});
      when(() => repo.updateFavorites(any())).thenAnswer((_) async => true);
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
            onGenerateRoute: (_) {
              return MaterialPageRoute(
                builder: (context) => child,
                settings: RouteSettings(arguments: pokemon),
              );
            },
          );
        },
      );
    }

    testWidgets('renders page', (tester) async {
      await tester.pumpWidget(
        getMaterialApp(
          BlocProvider<FavouritePokemonsCubit>(
            create: (context) => FavouritePokemonsCubit(
              repo: repo,
            ),
            child: const PokemonDetailPage(),
          ),
        ),
      );

      expect(find.byType(PokemonDetailPage), findsOneWidget);
      expect(find.byType(MarkFavouriteButton), findsOneWidget);
      expect(find.byType(LabelValueWidget), findsNWidgets(3));
      expect(find.byType(StatRow), findsNWidgets(6));
    });

    testWidgets('test favorite button', (tester) async {
      await tester.pumpWidget(
        getMaterialApp(
          BlocProvider<FavouritePokemonsCubit>(
            create: (context) => FavouritePokemonsCubit(
              repo: repo,
            ),
            child: const PokemonDetailPage(),
          ),
        ),
      );
      const unTappedText = 'Mark as favourite';

      expect(find.text(unTappedText), findsOneWidget);

      await tester.tap(find.text(unTappedText));

      await tester.pumpAndSettle();

      expect(find.text(unTappedText), findsNothing);
    });
  });
}
