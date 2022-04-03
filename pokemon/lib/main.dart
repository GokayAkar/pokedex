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
  WidgetsFlutterBinding.ensureInitialized();

  final _pokemonRepo = PokemonRepo(
    storageHandler: SharedPreferencesCacheHandler(
      prefs: await SharedPreferences.getInstance(),
    ),
  );

  //because we want to see latest version of favorite pokemons we only fetch them from API
  //but since we don't want to request pokemon again again while disposing and building again during scrolling
  //we cache them in memory in this map
  final _pokedex = <PokemonId, Pokemon>{};

  final settingsController = SettingsController(SettingsService());

  await settingsController.loadSettings();

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
