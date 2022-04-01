import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_api/pokemon_repo.dart';

import 'src/app.dart';
import 'src/utils/bloc_observer.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  // Set up the SettingsController, which will glue user settings to multiple
  // Flutter Widgets.
  WidgetsFlutterBinding.ensureInitialized();

  final _pokemonRepo = PokemonRepo(
    storageHandler: SharedPreferencesCacheHandler(
      prefs: await SharedPreferences.getInstance(),
    ),
  );

  //this map will hold all references for in memory pokemons
  //whenever we get a pokemon we will register it in this map
  //before get a pokemon we will look up to this map
  //because otherwise since allPokemons and favourites gonna work seperately
  //they can get same pokemon and we can hold 2 different ref for same pokemon
  final _pokedex = <PokemonId, Pokemon>{};

  final settingsController = SettingsController(SettingsService());

  // Load the user's preferred theme while the splash screen is displayed.
  // This prevents a sudden theme change when the app is first displayed.
  await settingsController.loadSettings();

  // Run the app and pass in the SettingsController. The app listens to the
  // SettingsController for changes, then passes it further down to the
  // SettingsView.
  runZonedGuarded(
    () {
      BlocOverrides.runZoned(
        () {
          runApp(
            MultiRepositoryProvider(
              providers: [
                RepositoryProvider<PokemonRepo>.value(
                  value: _pokemonRepo,
                ),
                RepositoryProvider<Map<PokemonId, Pokemon>>.value(
                  value: _pokedex,
                ),
              ],
              child: MyApp(settingsController: settingsController),
            ),
          );
        },
        blocObserver: MyBlocObserver(),
      );
    },
    (error, stack) {
      //TODO log dart errors
    },
  );
}
