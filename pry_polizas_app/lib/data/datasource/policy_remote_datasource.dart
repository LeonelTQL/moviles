import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../domain/entities/policy_entity.dart';
import '../models/policy_model.dart';

class PolicyRemoteDataSource {
  static const String rawBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://10.0.2.2:8000',
  );

  static const Duration requestTimeout = Duration(seconds: 8);

  final http.Client client;

  PolicyRemoteDataSource({http.Client? client}) : client = client ?? http.Client();

  String get baseUrl => rawBaseUrl.replaceAll(RegExp(r'/+$'), '');

  Uri _uri(String path) => Uri.parse('$baseUrl$path');

  Future<List<PolicyModel>> getPolicies() async {
    final response = await _send(client.get(_uri('/policies')));
    _validateResponse(response);

    final decoded = jsonDecode(utf8.decode(response.bodyBytes));
    if (decoded is! List) {
      throw Exception('La API no devolvió una lista válida de pólizas');
    }

    return decoded
        .whereType<Map<String, dynamic>>()
        .map((item) => PolicyModel.fromJson(item))
        .toList();
  }

  Future<PolicyModel> getPolicyByCode(String code) async {
    final safeCode = Uri.encodeComponent(code);
    final response = await _send(client.get(_uri('/policies/$safeCode')));
    _validateResponse(response);

    final decoded = jsonDecode(utf8.decode(response.bodyBytes));
    if (decoded is! Map<String, dynamic>) {
      throw Exception('La API no devolvió una póliza válida');
    }

    return PolicyModel.fromJson(decoded);
  }

  Future<PolicyModel> createPolicy(PolicyEntity policy) async {
    _validateDates(policy.fechaInicio, policy.fechaVencimiento);
    final model = PolicyModel.fromEntity(policy);
    final response = await _send(
      client.post(
        _uri('/policies'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(model.toJson()),
      ),
    );
    _validateResponse(response);

    final decoded = jsonDecode(utf8.decode(response.bodyBytes));
    if (decoded is! Map<String, dynamic>) {
      throw Exception('La API no devolvió la póliza creada');
    }

    return PolicyModel.fromJson(decoded);
  }

  Future<PolicyModel> updatePolicy(PolicyEntity policy) async {
    _validateDates(policy.fechaInicio, policy.fechaVencimiento);
    final safeCode = Uri.encodeComponent(policy.codigo);
    final model = PolicyModel.fromEntity(policy);
    final response = await _send(
      client.put(
        _uri('/policies/$safeCode'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(model.toUpdateJson()),
      ),
    );
    _validateResponse(response);

    final decoded = jsonDecode(utf8.decode(response.bodyBytes));
    if (decoded is! Map<String, dynamic>) {
      throw Exception('La API no devolvió la póliza actualizada');
    }

    return PolicyModel.fromJson(decoded);
  }

  void _validateDates(String inicioStr, String vencimientoStr) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final inicio = DateTime.parse(inicioStr);
    final vencimiento = DateTime.parse(vencimientoStr);

    if (inicio.isBefore(today)) {
      throw Exception('La fecha de inicio no puede ser anterior a la actual');
    }

    if (!vencimiento.isAfter(inicio)) {
      throw Exception('La fecha de vencimiento debe ser posterior a la de inicio');
    }

    final minVencimiento = DateTime(inicio.year, inicio.month + 1, inicio.day);
    if (vencimiento.isBefore(minVencimiento)) {
      throw Exception('La vigencia mínima de la póliza debe ser de un mes');
    }
  }

  Future<void> deletePolicy(String code) async {
    final safeCode = Uri.encodeComponent(code);
    final response = await _send(client.delete(_uri('/policies/$safeCode')));
    _validateResponse(response);
  }

  Future<http.Response> _send(Future<http.Response> request) async {
    try {
      return await request.timeout(requestTimeout);
    } on TimeoutException {
      throw Exception(
        'No se pudo conectar con la API. Revisa que FastAPI esté encendido y que la URL sea correcta.',
      );
    } on http.ClientException {
      throw Exception(
        'No se pudo llegar a la API. Para emulador Android usa http://10.0.2.2:8000 y para Chrome usa http://127.0.0.1:8000.',
      );
    } catch (_) {
      throw Exception(
        'No se pudo conectar con la API. Verifica el servidor y vuelve a intentar.',
      );
    }
  }

  void _validateResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return;
    }

    String message = 'Error ${response.statusCode} al consumir la API';
    try {
      final decoded = jsonDecode(utf8.decode(response.bodyBytes));
      if (decoded is Map<String, dynamic> && decoded['detail'] != null) {
        final detail = decoded['detail'];
        if (detail is List) {
          message = detail
              .map((item) => item is Map && item['msg'] != null ? item['msg'] : item.toString())
              .join('\n');
        } else {
          message = detail.toString();
        }
      }
    } catch (_) {
      message = response.body.isNotEmpty ? response.body : message;
    }

    throw Exception(message);
  }
}
