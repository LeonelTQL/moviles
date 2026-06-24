import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/pedido_model.dart';

class PedidoDatasource {
  final String baseUrl = "http://10.40.14.24:3000/api";

  Future<List<PedidoModel>> getPedidos() async {
    final response = await http.get(Uri.parse('$baseUrl/pedidos'));
    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      return data.map((json) => PedidoModel.fromJson(json)).toList();
    } else {
      throw Exception('Error al cargar pedidos');
    }
  }

  Future<PedidoModel> createPedido(PedidoModel pedido) async {
    final response = await http.post(
      Uri.parse('$baseUrl/pedidos'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(pedido.toJson()),
    );
    if (response.statusCode == 201) {
      final Map<String, dynamic> data = json.decode(response.body);
      // El backend devuelve { message: '...', pedido: { ... } }
      return PedidoModel.fromJson(data['pedido']);
    } else {
      throw Exception('Error al crear pedido');
    }
  }

  Future<PedidoModel> updatePedido(PedidoModel pedido) async {
    final response = await http.put(
      Uri.parse('$baseUrl/pedidos/${pedido.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(pedido.toJson()),
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return PedidoModel.fromJson(data['pedido']);
    } else {
      throw Exception('Error al actualizar pedido');
    }
  }

  Future<void> deletePedido(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/pedidos/$id'));
    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception('Error al eliminar pedido');
    }
  }
}
