import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pokemon_api/src/interfaces/network_interface.dart';

import '../models/models.dart';

class PokemonNotFound implements Exception {}

class RequestFailed implements Exception {
  final String? reason;

  const RequestFailed({this.reason});
}

class PokemonApiClient implements PokemonHttpHandler {
  /// {@macro meta_weather_api_client}
  PokemonApiClient({http.Client? httpClient}) : _httpClient = httpClient ?? http.Client();

  static const _baseUrl = 'pokeapi.co';
  final http.Client _httpClient;

  @override
  Future<Map<String, dynamic>> fetchPokemonDetail(PokemonId id) async {
    final pokemonRequest = Uri.https(
      _baseUrl,
      '/api/v2/pokemon/$id',
    );
    final pokemonResponse = await _httpClient.get(pokemonRequest);

    if (pokemonResponse.statusCode == 404) {
      throw PokemonNotFound();
    }

    if (pokemonResponse.statusCode != 200) {
      throw RequestFailed(reason: 'request: $pokemonRequest - statusCode:${pokemonResponse.statusCode} - responseBody:${pokemonResponse.body}');
    }

    return json.decode(pokemonResponse.body);
  }

  @override
  Future<Map<String, dynamic>> fetchPokemons({required int limit, required int offset}) async {
    final request = Uri.https(_baseUrl, 'api/v2/pokemon', <String, String>{
      'limit': limit.toString(),
      'offset': offset.toString(),
    });

    final response = await _httpClient.get(request);

    if (response.statusCode != 200) {
      throw RequestFailed(reason: 'request: $request -  statusCode: ${response.statusCode} - responseBody: ${response.body}');
    }

    return json.decode(response.body);
  }
}
