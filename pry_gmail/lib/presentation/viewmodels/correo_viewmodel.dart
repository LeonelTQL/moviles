import 'package:flutter/foundation.dart';

import '../../data/repositories/correo_repository_impl.dart';
import '../../domain/entities/correo_entity.dart';
import '../../domain/usecases/buscar_correos_usecase.dart';
import '../../domain/usecases/cambiar_estado_lectura_usecase.dart';
import '../../domain/usecases/contar_no_leidos_usecase.dart';
import '../../domain/usecases/enviar_correo_real_usecase.dart';
import '../../domain/usecases/leer_correos_reales_usecase.dart';
import '../../domain/usecases/marcar_todos_leidos_usecase.dart';
import '../../domain/usecases/obtener_correos_usecase.dart';
import '../../domain/usecases/recibir_correo_usecase.dart';
import '../../domain/usecases/redactar_correo_usecase.dart';

class CorreoViewModel extends ChangeNotifier {
  final ObtenerCorreosUseCase _obtenerCorreosUseCase;
  final BuscarCorreosUseCase _buscarCorreosUseCase;
  final ContarNoLeidosUseCase _contarNoLeidosUseCase;
  final MarcarTodosLeidosUseCase _marcarTodosLeidosUseCase;
  final RecibirCorreoUseCase _recibirCorreoUseCase;
  final RedactarCorreoUseCase _redactarCorreoUseCase;
  final CambiarEstadoLecturaUseCase _cambiarEstadoLecturaUseCase;
  final EnviarCorreoRealUseCase _enviarCorreoRealUseCase;
  final LeerCorreosRealesUseCase _leerCorreosRealesUseCase;

  List<CorreoEntity> _correos = [];
  String _busqueda = '';
  bool _cargando = false;
  bool _procesandoGmail = false;
  String? _mensajeError;

  CorreoViewModel({required CorreoRepositoryImpl repository})
      : _obtenerCorreosUseCase = ObtenerCorreosUseCase(repository),
        _buscarCorreosUseCase = BuscarCorreosUseCase(repository),
        _contarNoLeidosUseCase = ContarNoLeidosUseCase(repository),
        _marcarTodosLeidosUseCase = MarcarTodosLeidosUseCase(repository),
        _recibirCorreoUseCase = RecibirCorreoUseCase(repository),
        _redactarCorreoUseCase = RedactarCorreoUseCase(repository),
        _cambiarEstadoLecturaUseCase = CambiarEstadoLecturaUseCase(repository),
        _enviarCorreoRealUseCase = EnviarCorreoRealUseCase(repository),
        _leerCorreosRealesUseCase = LeerCorreosRealesUseCase(repository);

  List<CorreoEntity> get correos => List.unmodifiable(_correos);

  List<CorreoEntity> get correosFiltrados => _buscarCorreosUseCase(_correos, _busqueda);

  int get noLeidos => _contarNoLeidosUseCase(_correos);

  String get busqueda => _busqueda;

  bool get cargando => _cargando;

  bool get procesandoGmail => _procesandoGmail;

  String? get mensajeError => _mensajeError;

  Future<void> cargarCorreos() async {
    _cargando = true;
    _mensajeError = null;
    notifyListeners();

    try {
      _correos = await _obtenerCorreosUseCase();
    } catch (error) {
      _mensajeError = error.toString();
    } finally {
      _cargando = false;
      notifyListeners();
    }
  }

  void actualizarBusqueda(String valor) {
    _busqueda = valor;
    notifyListeners();
  }

  Future<void> recibirNuevoCorreo() async {
    await _recibirCorreoUseCase();
    await cargarCorreos();
  }

  Future<void> marcarTodosLeidos() async {
    await _marcarTodosLeidosUseCase();
    await cargarCorreos();
  }

  Future<void> marcarComoLeido(CorreoEntity correo) async {
    if (correo.leido) {
      return;
    }

    await _cambiarEstadoLecturaUseCase(correo);
    await cargarCorreos();
  }

  Future<void> redactarCorreo({
    required String destinatario,
    required String asunto,
    required String mensaje,
    bool enviado = false,
  }) async {
    final correo = CorreoEntity(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      remitente: 'Yo',
      destinatario: destinatario,
      asunto: asunto,
      mensaje: mensaje,
      fecha: DateTime.now(),
      leido: true,
      enviado: enviado,
    );

    await _redactarCorreoUseCase(correo);
    await cargarCorreos();
  }

  Future<bool> enviarCorreoReal({
    required String destinatario,
    required String asunto,
    required String mensaje,
  }) async {
    _procesandoGmail = true;
    _mensajeError = null;
    notifyListeners();

    try {
      final enviado = await _enviarCorreoRealUseCase(
        destinatario: destinatario,
        asunto: asunto,
        mensaje: mensaje,
      );

      if (enviado) {
        await redactarCorreo(
          destinatario: destinatario,
          asunto: asunto,
          mensaje: mensaje,
          enviado: true,
        );
      }

      return enviado;
    } catch (error) {
      _mensajeError = error.toString();
      return false;
    } finally {
      _procesandoGmail = false;
      notifyListeners();
    }
  }

  Future<bool> sincronizarConGmailReal() async {
    _procesandoGmail = true;
    _mensajeError = null;
    notifyListeners();

    try {
      final correosReales = await _leerCorreosRealesUseCase();
      _correos = correosReales;
      return true;
    } catch (error) {
      _mensajeError = error.toString();
      return false;
    } finally {
      _procesandoGmail = false;
      notifyListeners();
    }
  }
}
