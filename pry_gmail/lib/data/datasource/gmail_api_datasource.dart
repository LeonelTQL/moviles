import 'dart:convert';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

import '../models/correo_model.dart';
import 'gmail_config.dart';

class GmailApiDatasource {
  late final GoogleSignIn _googleSignIn;

  GmailApiDatasource({String? serverClientId}) {
    _googleSignIn = GoogleSignIn(
      serverClientId: serverClientId == null || serverClientId.isEmpty ? null : serverClientId,
      scopes: const [
        GmailConfig.scopeEmail,
        GmailConfig.scopeGmailSend,
        GmailConfig.scopeGmailReadOnly,
      ],
    );
  }

  Future<GoogleSignInAccount> iniciarSesion() async {
    final account = await _googleSignIn.signIn();
    if (account == null) {
      throw Exception('No se inició sesión con Google.');
    }
    return account;
  }

  Future<void> cerrarSesion() async {
    await _googleSignIn.signOut();
  }

  Future<bool> enviarCorreo({
    required String destinatario,
    required String asunto,
    required String mensaje,
  }) async {
    final account = await iniciarSesion();
    final headers = await account.authHeaders;

    final rawMessage = _crearMensajeMime(
      destinatario: destinatario,
      asunto: asunto,
      mensaje: mensaje,
    );

    final response = await http.post(
      Uri.parse('https://gmail.googleapis.com/gmail/v1/users/me/messages/send'),
      headers: {
        ...headers,
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'raw': rawMessage}),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    }

    throw Exception('Gmail API no pudo enviar el correo: ${response.statusCode} ${response.body}');
  }

  Future<List<CorreoModel>> leerMensajes({int maxResults = 10}) async {
    final account = await iniciarSesion();
    final headers = await account.authHeaders;

    final listResponse = await http.get(
      Uri.https(
        'gmail.googleapis.com',
        '/gmail/v1/users/me/messages',
        {
          'maxResults': '$maxResults',
          'q': 'in:inbox',
        },
      ),
      headers: headers,
    );

    if (listResponse.statusCode != 200) {
      throw Exception('No se pudieron leer los correos: ${listResponse.statusCode} ${listResponse.body}');
    }

    final decoded = jsonDecode(listResponse.body) as Map<String, dynamic>;
    final messages = decoded['messages'] as List<dynamic>? ?? [];
    final correos = <CorreoModel>[];

    for (final item in messages) {
      final messageId = item['id'] as String;
      final detailResponse = await http.get(
        Uri.https(
          'gmail.googleapis.com',
          '/gmail/v1/users/me/messages/$messageId',
          {'format': 'metadata'},
        ),
        headers: headers,
      );

      if (detailResponse.statusCode != 200) {
        continue;
      }

      final detail = jsonDecode(detailResponse.body) as Map<String, dynamic>;
      final payload = detail['payload'] as Map<String, dynamic>? ?? {};
      final gmailHeaders = payload['headers'] as List<dynamic>? ?? [];
      final labels = (detail['labelIds'] as List<dynamic>? ?? []).map((label) => label.toString()).toList();

      correos.add(
        CorreoModel(
          id: detail['id'] as String,
          remitente: _obtenerHeader(gmailHeaders, 'From'),
          destinatario: account.email,
          asunto: _obtenerHeader(gmailHeaders, 'Subject').isEmpty ? 'Sin asunto' : _obtenerHeader(gmailHeaders, 'Subject'),
          mensaje: detail['snippet'] as String? ?? 'Sin vista previa disponible.',
          fecha: DateTime.now(),
          leido: !labels.contains('UNREAD'),
          enviado: false,
        ),
      );
    }

    return correos;
  }

  String _crearMensajeMime({
    required String destinatario,
    required String asunto,
    required String mensaje,
  }) {
    final mime = [
      'To: $destinatario',
      'Subject: ${_codificarHeader(asunto)}',
      'MIME-Version: 1.0',
      'Content-Type: text/plain; charset="UTF-8"',
      'Content-Transfer-Encoding: 8bit',
      '',
      mensaje,
    ].join('\r\n');

    return base64UrlEncode(utf8.encode(mime)).replaceAll('=', '');
  }

  String _codificarHeader(String value) {
    return '=?UTF-8?B?${base64Encode(utf8.encode(value))}?=';
  }

  String _obtenerHeader(List<dynamic> headers, String name) {
    for (final item in headers) {
      if (item is Map<String, dynamic> &&
          item['name']?.toString().toLowerCase() == name.toLowerCase()) {
        return item['value']?.toString() ?? '';
      }
    }

    return '';
  }
}
