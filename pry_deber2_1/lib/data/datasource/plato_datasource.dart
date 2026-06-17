import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/plato_model.dart';

class PlatoDatasource {
  final String baseUrl = "http://10.0.2.2:3000/api"; // Para emulador Android

  Future<List<PlatoModel>> getPlatos() async {
    final response = await http.get(Uri.parse('$baseUrl/platos'));
    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      return data.map((json) => PlatoModel.fromJson(json)).toList();
    } else {
      throw Exception('Error al cargar platos');
    }
  }

  Future<PlatoModel> getPlatoById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/platos/$id'));
    if (response.statusCode == 200) {
      return PlatoModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error al cargar plato');
    }
  }

  Future<PlatoModel> createPlato(PlatoModel plato) async {
    final response = await http.post(
      Uri.parse('$baseUrl/platos'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(plato.toJson()),
    );
    if (response.statusCode == 201) {
      return PlatoModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error al crear plato');
    }
  }

  Future<PlatoModel> updatePlato(PlatoModel plato) async {
    final response = await http.put(
      Uri.parse('$baseUrl/platos/${plato.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(plato.toJson()),
    );
    if (response.statusCode == 200) {
      return PlatoModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error al actualizar plato');
    }
  }

  Future<void> deletePlato(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/platos/$id'));
    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception('Error al eliminar plato');
    }
  }
}
