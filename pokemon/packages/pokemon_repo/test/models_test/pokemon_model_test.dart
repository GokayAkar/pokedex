import 'package:flutter_test/flutter_test.dart';
import 'package:pokemon_api/src/models/models.dart';

void main() {
  late final Map<String, dynamic> pokemonJson;
  late final Pokemon pokemon;
  late final List<PokemonType> types;
  late final List<String> typesJson;
  late final List<PokemonStat> stats;
  late final List<Map<String, dynamic>> statsJson;
  late final String imageUrl;

  setUpAll(() {
    imageUrl = 'exampleUrl';

    types = [
      const Fire(),
      const Water(),
      const UnknownType(name: 'Random'),
    ];

    typesJson = [
      'Fire',
      'Water',
      'Random',
    ];

    stats = [
      const PokemonStat(name: 'Hp', value: 20),
      const PokemonStat(name: 'Attack', value: 30),
      const PokemonStat(name: 'Defence', value: 40),
      const PokemonStat(name: 'Special_attack', value: 50),
      const PokemonStat(name: 'Special_defence', value: 60),
      const PokemonStat(name: 'Speed', value: 70),
    ];

    statsJson = [
      {
        'value': 20,
        'name': 'Hp',
      },
      {
        'value': 30,
        'name': 'Attack',
      },
      {
        'value': 40,
        'name': 'Defence',
      },
      {
        'value': 50,
        'name': 'Special_attack',
      },
      {
        'value': 60,
        'name': 'Special_defence',
      },
      {
        'value': 70,
        'name': 'Speed',
      },
    ];

    pokemonJson = {
      'id': 1,
      'name': 'Clefairy',
      'types': typesJson,
      'imageUrl': imageUrl,
      'stats': statsJson,
      'height': 10,
      'weight': 100,
      'bmi': 1,
      'avgPower': 45,
    };

    pokemon = Pokemon(
      id: 1,
      name: 'Clefairy',
      types: types,
      imageUrl: imageUrl,
      height: 10,
      weight: 100,
      stats: stats,
    );
  });

  group('pokemon type', () {
    test('fromJson', (() {
      final pokemonTypes = typesJson.map((e) => PokemonType.fromString(name: e)).toList();

      expect(pokemonTypes[0], isA<Fire>());
      expect(pokemonTypes[1], isA<Water>());
      expect(pokemonTypes[2], isA<UnknownType>());
      expect(pokemonTypes[2].name, equals(typesJson[2]));
    }));

    test('fromJson', (() {
      final pokemonTypeJson = types.map((e) => e.name).toList();

      expect(pokemonTypeJson[0], equals(typesJson[0]));
      expect(pokemonTypeJson[1], equals(typesJson[1]));
      expect(pokemonTypeJson[2], equals(typesJson[2]));
      expect(pokemonTypeJson, isA<List<String>>());
    }));
  });

  group('pokemon stats', () {
    test('fromJson', () {
      final pokemonStats = statsJson.map((e) => PokemonStat.fromJson(e)).toList();

      expect(pokemonStats, isA<List<PokemonStat>>());
      expect(pokemonStats[0].name, equals(statsJson[0]['name']));
      expect(pokemonStats[0].value, equals(statsJson[0]['value']));
      expect(pokemonStats[0], equals(stats[0]));
      expect(pokemonStats[1], equals(stats[1]));
      expect(pokemonStats[2], equals(stats[2]));
    });

    test('toJson', () {
      final statsJson = stats.map((e) => e.toJson()).toList();

      expect(statsJson, isA<List<Map<String, dynamic>>>());
      expect(statsJson[0]['name'], equals(stats[0].name));
      expect(statsJson[0]['value'], equals(stats[0].value));
    });
  });

  group('pokemon', () {
    test('bmi', () {
      expect(pokemon.bmi, equals(1));
    });

    test('avgPower', () {
      expect(pokemon.avgPower, equals(45));
    });
    test('fromJson', () {
      final newPokemon = Pokemon.fromJson(pokemonJson);

      expect(newPokemon, isA<Pokemon>());
      expect(newPokemon, equals(pokemon));
    });

    test('toJson', () {
      final newPokemonJson = pokemon.toJson();

      expect(newPokemonJson, isA<Map<String, dynamic>>());
      expect(newPokemonJson, equals(pokemonJson));
    });

    test('typeString getter', () {
      expect(pokemon.typesString, equals('Fire, Water, Random'));
    });
  });
}
