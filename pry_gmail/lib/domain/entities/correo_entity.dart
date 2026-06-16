class CorreoEntity {
  final String id;
  final String remitente;
  final String destinatario;
  final String asunto;
  final String mensaje;
  final DateTime fecha;
  final bool leido;
  final bool enviado;

  const CorreoEntity({
    required this.id,
    required this.remitente,
    required this.destinatario,
    required this.asunto,
    required this.mensaje,
    required this.fecha,
    required this.leido,
    required this.enviado,
  });

  CorreoEntity copyWith({
    String? id,
    String? remitente,
    String? destinatario,
    String? asunto,
    String? mensaje,
    DateTime? fecha,
    bool? leido,
    bool? enviado,
  }) {
    return CorreoEntity(
      id: id ?? this.id,
      remitente: remitente ?? this.remitente,
      destinatario: destinatario ?? this.destinatario,
      asunto: asunto ?? this.asunto,
      mensaje: mensaje ?? this.mensaje,
      fecha: fecha ?? this.fecha,
      leido: leido ?? this.leido,
      enviado: enviado ?? this.enviado,
    );
  }
}
