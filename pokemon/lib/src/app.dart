import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pokemon/src/pokemon/favourite_pokemons/favourite_pokemons.dart';
import 'package:pokemon/src/pokemon/home/home.dart';
import 'package:pokemon/src/pokemon/intro/intro.dart';
import 'package:pokemon/src/pokemon/pokemon_detail/pokemon_detail.dart';
import 'package:pokemon_api/pokemon_repo.dart';

import 'constants/constants.dart';
import 'pokemon/all_pokemons/all_pokemons.dart';
import 'settings/settings_controller.dart';
import 'settings/settings_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
    required this.settingsController,
  }) : super(key: key);

  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AllPokemonsCubit>(
          create: (_) => AllPokemonsCubit(
            controller: PagingController(firstPageKey: 0),
            repo: context.read<PokemonRepo>(),
          ),
        ),
        BlocProvider<FavouritePokemonsCubit>(
          create: (context) => FavouritePokemonsCubit(
            repo: context.read<PokemonRepo>(),
          ),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: () => AnimatedBuilder(
          animation: settingsController,
          builder: (BuildContext context, Widget? child) {
            return MaterialApp(
              builder: (context, child) {
                ScreenUtil.setContext(context);
                FontSizes.initProportionedFontSizes();

                return MediaQuery(
                  data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                  child: child!,
                );
              },
              restorationScopeId: 'app',
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: const [
                Locale('en', ''),
              ],
              onGenerateTitle: (BuildContext context) => AppLocalizations.of(context)!.appTitle,
              theme: ThemeData(
                fontFamily: Fonts.notoSans,
                scaffoldBackgroundColor: AppColors.homeBackgroundColor,
              ),
              darkTheme: ThemeData.dark(),
              themeMode: settingsController.themeMode,
              onGenerateRoute: (RouteSettings routeSettings) {
                return MaterialPageRoute<void>(
                  settings: routeSettings,
                  builder: (BuildContext context) {
                    switch (routeSettings.name) {
                      case HomePage.routeName:
                        return const HomePage();
                      case PokemonDetailPage.routeName:
                        return const PokemonDetailPage();
                      case SettingsView.routeName:
                        return SettingsView(controller: settingsController);
                      default:
                        return const AppIntroPage();
                    }
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
