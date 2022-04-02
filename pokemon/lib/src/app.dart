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

/// The Widget that configures your application.
class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
    required this.settingsController,
  }) : super(key: key);

  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    // Glue the SettingsController to the MaterialApp.
    //
    // The AnimatedBuilder Widget listens to the SettingsController for changes.
    // Whenever the user updates their settings, the MaterialApp is rebuilt.
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
              // Providing a restorationScopeId allows the Navigator built by the
              // MaterialApp to restore the navigation stack when a user leaves and
              // returns to the app after it has been killed while running in the
              // background.
              restorationScopeId: 'app',

              // Provide the generated AppLocalizations to the MaterialApp. This
              // allows descendant Widgets to display the correct translations
              // depending on the user's locale.
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: const [
                Locale('en', ''), // English, no country code
              ],

              // Use AppLocalizations to configure the correct application title
              // depending on the user's locale.
              //
              // The appTitle is defined in .arb files found in the localization
              // directory.
              onGenerateTitle: (BuildContext context) => AppLocalizations.of(context)!.appTitle,

              // Define a light and dark color theme. Then, read the user's
              // preferred ThemeMode (light, dark, or system default) from the
              // SettingsController to display the correct theme.
              theme: ThemeData(
                fontFamily: Fonts.notoSans,
                scaffoldBackgroundColor: AppColors.homeBackgroundColor,
              ),
              darkTheme: ThemeData.dark(),
              themeMode: settingsController.themeMode,

              // Define a function to handle named routes in order to support
              // Flutter web url navigation and deep linking.
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
