import '../models/correo_model.dart';

class CorreoLocalDatasource {
  final List<CorreoModel> _correos = [
    CorreoModel(
      id: '1',
      remitente: 'Docente de Móviles',
      destinatario: 'leonel06tipan@gmail.com',
      asunto: 'Revisión del widget tipo Gmail',
      mensaje: 'Recuerda aplicar MVVM, Provider y separar correctamente las carpetas del proyecto.',
      fecha: DateTime.now().subtract(const Duration(minutes: 8)),
      leido: false,
      enviado: false,
    ),
    CorreoModel(
      id: '2',
      remitente: 'Google Cloud',
      destinatario: 'leonel06tipan@gmail.com',
      asunto: 'Configura OAuth para Gmail API',
      mensaje: 'Activa Gmail API, configura la pantalla de consentimiento y crea tus credenciales OAuth.',
      fecha: DateTime.now().subtract(const Duration(hours: 1, minutes: 20)),
      leido: false,
      enviado: false,
    ),
    CorreoModel(
      id: '3',
      remitente: 'Equipo Flutter',
      destinatario: 'leonel06tipan@gmail.com',
      asunto: 'Provider actualizó la interfaz',
      mensaje: 'Este correo de prueba sirve para comprobar que notifyListeners reconstruye la pantalla.',
      fecha: DateTime.now().subtract(const Duration(hours: 4)),
      leido: true,
      enviado: false,
    ),
  ];

  Future<List<CorreoModel>> obtenerCorreos() async {
    _correos.sort((a, b) => b.fecha.compareTo(a.fecha));
    return List<CorreoModel>.from(_correos);
  }

  Future<void> guardarCorreo(CorreoModel correo) async {
    _correos.insert(0, correo);
  }

  Future<void> actualizarCorreo(CorreoModel correo) async {
    final index = _correos.indexWhere((item) => item.id == correo.id);
    if (index != -1) {
      _correos[index] = correo;
    }
  }

  Future<void> marcarTodosLeidos() async {
    for (int i = 0; i < _correos.length; i++) {
      _correos[i] = _correos[i].copyWith(leido: true);
    }
  }

  Future<void> recibirNuevoCorreo() async {
    final id = DateTime.now().microsecondsSinceEpoch.toString();
    final correo = CorreoModel(
      id: id,
      remitente: 'Notificación simulada',
      destinatario: 'leonel06tipan@gmail.com',
      asunto: 'Nuevo correo recibido #${_correos.length + 1}',
      mensaje: 'Este mensaje fue creado en memoria para simular la llegada de un correo nuevo.',
      fecha: DateTime.now(),
      leido: false,
      enviado: false,
    );

    _correos.insert(0, correo);
  }
}
