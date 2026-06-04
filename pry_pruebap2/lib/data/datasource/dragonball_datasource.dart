import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/character_model.dart';

class DragonBallDatasource {
  final String baseUrl = 'https://dragonball-api.com/api/characters';

  Future<List<CharacterModel>> fetchCharacters() async {
    final url = Uri.parse('$baseUrl?limit=100');
    final resp = await http.get(url);

    if (resp.statusCode != 200) {
      throw Exception('Error al cargar personajes de Dragon Ball');
    }

    final data = jsonDecode(resp.body);
    final List result = data is List ? data : data["items"];

    return result.map((e) => CharacterModel.fromJson(e)).toList();
  }

  Future<CharacterModel> fetchCharacterById(int id) async {
    final url = Uri.parse('$baseUrl/$id');
    final resp = await http.get(url);

    if (resp.statusCode != 200) {
      throw Exception('Error al cargar el personaje');
    }

    final data = jsonDecode(resp.body);
    return CharacterModel.fromJson(data);
  }
}
