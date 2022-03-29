import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pokemon_api/src/interfaces/network_interface.dart';

class PokemonNotFound implements Exception {}

class RequestFailed implements Exception {}

class PokemonApiClient implements PokemonHttpHandler {
  /// {@macro meta_weather_api_client}
  PokemonApiClient({http.Client? httpClient}) : _httpClient = httpClient ?? http.Client();

  static const _baseUrl = 'https://pokeapi.co/api/v2';
  final http.Client _httpClient;

  @override
  Future<Map<String, dynamic>> fetchPokemon(int id) async {
    final pokemonRequest = Uri.https(
      _baseUrl,
      '/pokemon/$id',
    );
    final pokemonResponse = await _httpClient.get(pokemonRequest);

    if (pokemonResponse.statusCode == 404) {
      throw PokemonNotFound();
    }

    if (pokemonResponse.statusCode != 200) {
      throw RequestFailed();
    }

    return json.decode(pokemonResponse.body);
  }
}
