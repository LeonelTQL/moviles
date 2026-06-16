import '../../domain/entities/correo_entity.dart';

class CorreoModel extends CorreoEntity {
  const CorreoModel({
    required super.id,
    required super.remitente,
    required super.destinatario,
    required super.asunto,
    required super.mensaje,
    required super.fecha,
    required super.leido,
    required super.enviado,
  });

  factory CorreoModel.fromEntity(CorreoEntity correo) {
    return CorreoModel(
      id: correo.id,
      remitente: correo.remitente,
      destinatario: correo.destinatario,
      asunto: correo.asunto,
      mensaje: correo.mensaje,
      fecha: correo.fecha,
      leido: correo.leido,
      enviado: correo.enviado,
    );
  }

  factory CorreoModel.fromMap(Map<String, dynamic> map) {
    return CorreoModel(
      id: map['id'] as String,
      remitente: map['remitente'] as String,
      destinatario: map['destinatario'] as String? ?? '',
      asunto: map['asunto'] as String,
      mensaje: map['mensaje'] as String,
      fecha: DateTime.parse(map['fecha'] as String),
      leido: map['leido'] as bool,
      enviado: map['enviado'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'remitente': remitente,
      'destinatario': destinatario,
      'asunto': asunto,
      'mensaje': mensaje,
      'fecha': fecha.toIso8601String(),
      'leido': leido,
      'enviado': enviado,
    };
  }

  @override
  CorreoModel copyWith({
    String? id,
    String? remitente,
    String? destinatario,
    String? asunto,
    String? mensaje,
    DateTime? fecha,
    bool? leido,
    bool? enviado,
  }) {
    return CorreoModel(
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
