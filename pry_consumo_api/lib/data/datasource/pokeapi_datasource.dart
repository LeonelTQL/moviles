import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/pokemon_model.dart';


class PokeApiDatasource {

  final String baseUrl ='https://pokeapi.co/api/v2/pokemon';

  Future<List<PokemonModel>> fetchPokemon(int limit, int offset) async {
    final url = Uri.parse('$baseUrl?limit=$limit&offset=$offset');

    final resp = await http.get(url);

    if (resp.statusCode != 200){
      throw Exception('Error al cargar pokemon');
    }

    final data = jsonDecode(resp.body);
    final List result = data["results"];

    return result.map((e) => PokemonModel.fromJson(e)).toList();
  }
}
