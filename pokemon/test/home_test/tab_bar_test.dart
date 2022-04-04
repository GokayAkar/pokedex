import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokemon/src/constants/font_sizes.dart';
import 'package:pokemon/src/pokemon/favourite_pokemons/cubits/favourite_pokemons_cubit.dart';
import 'package:pokemon/src/pokemon/home/home.dart';
import 'package:pokemon_api/pokemon_repo.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mocktail/mocktail.dart';

class MockPokemonRepo extends Mock implements PokemonRepo {}

void main() {
  group('pokemon tab bar ', () {
    late PokemonRepo repo;
    late FavouritePokemonsCubit cubit;

    setUp(() {
      repo = MockPokemonRepo();
      when(() => repo.getFavoritePokemons()).thenAnswer((_) async => {2, 3, 4});
      when(() => repo.updateFavorites(any())).thenAnswer((_) async => true);
      cubit = FavouritePokemonsCubit(repo: repo);
    });

    tearDown(() {
      cubit.close();
    });

    Widget getMaterialApp(Widget child) {
      return ScreenUtilInit(
        designSize: const Size(750, 1624),
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

    testWidgets('renders tab bar', (tester) async {
      await tester.pumpWidget(
        getMaterialApp(
          BlocProvider<FavouritePokemonsCubit>.value(
            value: cubit,
            child: DefaultTabController(
              length: 2,
              child: Scaffold(
                appBar: AppBar(
                  bottom: const PokedexTabBar(),
                ),
                body: const SizedBox(),
              ),
            ),
          ),
        ),
      );

      expect(find.byType(PokedexTabBar), findsOneWidget);
      expect(find.byType(TabBar), findsOneWidget);
      expect(find.byType(Tab), findsNWidgets(2));
      expect(find.text('All Pokemons'), findsOneWidget);
      expect(find.text('Favourites'), findsOneWidget);
    });

    testWidgets('favorite count ui changes when favorite added', (tester) async {
      await tester.pumpWidget(
        getMaterialApp(
          BlocProvider<FavouritePokemonsCubit>.value(
            value: cubit,
            child: DefaultTabController(
              length: 2,
              child: Scaffold(
                appBar: AppBar(
                  bottom: const PokedexTabBar(),
                ),
                body: const SizedBox(),
              ),
            ),
          ),
        ),
      );
      const favoriteCount = '3';

      expect(find.text(favoriteCount), findsOneWidget);

      cubit.updateFavourites(4);

      await tester.pumpAndSettle();

      expect(find.text(favoriteCount), findsNothing);
    });
  });
}
