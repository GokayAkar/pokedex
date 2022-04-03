# pokemon

Pokedex app to view all pokemon and keep a record of your favorite pokemon!

## To Run Project

All you have to do is clone the repo and run the project.

If you get an error with the AppLocalizations file there is an issue with finding generated localization file.In this case please restart the dart analysis server.VSCode:View -> Command Palette (or cmd/ctrl shift p) Dart Restart Analysis ServerAndroid Studio, Intellij:Find the Dart Analysis button next Terminal button and restart the dart analysis server.

## Getting Started

Project created with the skeleton template introduced with Flutter 2.5 version.
Settings, theme, and localization services come with this template but since the design doesn't include them I didn't implement them.

## Packages

flutter_bloc:
I used bloc state management for the project. Because logic in the state management components is not complex I used cubits instead of bloc to avoid boilerplate and keep it simple.
If logic gets complicated in the future it is pretty easy to convert cubits to blocs. 
I picked bloc because the documentation is too good. Maintainers are one of the biggest flutter development companies and they care users of the package and maintain the package well. 
Also, the community has embraced the package so in any problem there are a lot of resources.
https://bloclibrary.dev/

infinite_scroll_pagination:
I preferred this package for pagination instead of implementing it by myself.
Because it has very good documentation, is well maintained, and is the most used pagination package for flutter which brings a lot of liveliness and additional resources if a problem arises.
https://pub.dev/packages/infinite_scroll_pagination

flutter_screenutil:
This is one of the best packages when the developer has a design with all the height and width values to implement pixel-perfect UI. 
When design logical pixes values provided to the package it proportionate design values for the device running app.
https://pub.dev/packages/flutter_screenutil

cached_network_image:
Every pokemon has an image and fetching them every time would mean a lot of waste. To prevent this we are using this package to cache images.
https://pub.dev/packages/cached_network_image

pokemon_repo:
This package was created for the manage app's data domain. It includes all logic to get pokemon info from local storage or rest API and cache it in local storage.
Also includes logic for getting favorite pokemon from local storage and writing them to local storage when favorite pokemons are updated.
It depends on two different interfaces, PokemonLocalStorageHandler and PokemonHttpHandler, and implements those methods;

Future<PokemonPaginationResponse> getPokemonsToFetch({required int limit, required int offset});
Future<Pokemon> getPokemon(PokemonId id, {bool fetchLatest = false});
Future<bool> updateFavorites(Set<PokemonId> ids);
Future<Set<PokemonId>> getFavoritePokemons();

getPokemonsToFetch is returning pokemon ids and names with the info of if there are still left pokemons to fetch.
Limit means the count of pokemon id and name we want for the request and offset is the start index of pokemons we want to fetch.
For example, if the limit is 12 and the offset is 100 it means we want the 12 pokemon between 100 - 112 (100 excluded, 112 included)

getPokemon method is returning pokemon for the given id. Normal case it checks the local storage first for the given id if cannot find pokemon then fetch it from API.
But since we want to show the most up-to-date version of a pokemon in the favorites tab there is a fetchLatest parameter to override cache check and fetch the latest from API.

The last two methods' name is pretty self-explanatory.

The class implementing local storage handler must have those methods;

abstract class PokemonLocalStorageHandler { 
    FutureOr<bool> savePokemon(Pokemon pokemon); 
    FutureOr<Map<String, dynamic>?>? readPokemon(PokemonId id); 
    FutureOr<bool> updateFavorites(Set<PokemonId> ids); 
    FutureOr<Set<PokemonId>> getFavorites();
    }
And class implementing HTTP part of repo must have those methods;

abstract class PokemonHttpHandler { 
    Future<Map<String, dynamic>> fetchPokemonDetail(PokemonId id); 
    Future<Map<String, dynamic>> fetchPokemons({required int limit, required int offset});
    }

## Assets

App has two diffent assets. One for colored Pokeball image and another alpha colored one for pokemon detail pokemon image background.
Both have different versions for the best experience in devices with different pixel densities.

## Localization

This project generates localized messages based on arb files found inthe `lib/src/localization` directory.
To support additional languages, please visit the tutorial on[Internationalizing Flutterapps]
(https://flutter.dev/docs/development/accessibility-and-localization/internationalization)