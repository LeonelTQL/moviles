import '../../domain/entities/correo_entity.dart';
import '../datasource/correo_local_datasource.dart';
import '../datasource/gmail_api_datasource.dart';
import '../models/correo_model.dart';

class CorreoRepositoryImpl {
  final CorreoLocalDatasource localDatasource;
  final GmailApiDatasource gmailApiDatasource;

  CorreoRepositoryImpl({
    required this.localDatasource,
    required this.gmailApiDatasource,
  });

  Future<List<CorreoEntity>> obtenerCorreos() {
    return localDatasource.obtenerCorreos();
  }

  Future<void> guardarCorreo(CorreoEntity correo) {
    return localDatasource.guardarCorreo(CorreoModel.fromEntity(correo));
  }

  Future<void> actualizarCorreo(CorreoEntity correo) {
    return localDatasource.actualizarCorreo(CorreoModel.fromEntity(correo));
  }

  List<CorreoEntity> buscarCorreos(List<CorreoEntity> correos, String filtro) {
    final texto = filtro.trim().toLowerCase();
    if (texto.isEmpty) {
      return correos;
    }

    return correos.where((correo) {
      return correo.asunto.toLowerCase().contains(texto) ||
          correo.remitente.toLowerCase().contains(texto) ||
          correo.destinatario.toLowerCase().contains(texto);
    }).toList();
  }

  int contarNoLeidos(List<CorreoEntity> correos) {
    return correos.where((correo) => !correo.leido).length;
  }

  Future<void> marcarTodosLeidos() {
    return localDatasource.marcarTodosLeidos();
  }

  Future<void> recibirNuevoCorreo() {
    return localDatasource.recibirNuevoCorreo();
  }

  Future<bool> enviarCorreoReal({
    required String destinatario,
    required String asunto,
    required String mensaje,
  }) {
    return gmailApiDatasource.enviarCorreo(
      destinatario: destinatario,
      asunto: asunto,
      mensaje: mensaje,
    );
  }

  Future<List<CorreoEntity>> leerCorreosReales() {
    return gmailApiDatasource.leerMensajes();
  }

  Future<void> cerrarSesionGmail() {
    return gmailApiDatasource.cerrarSesion();
  }
}
