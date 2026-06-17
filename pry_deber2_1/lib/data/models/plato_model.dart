import '../../domain/entities/plato.dart';

class PlatoModel extends Plato {
  PlatoModel({
    super.id,
    required super.nombre,
    required super.descripcion,
    required super.precio,
    required super.disponible,
    required super.imagenUrl,
  });

  factory PlatoModel.fromJson(Map<String, dynamic> json) {
    return PlatoModel(
      id: json['id'],
      nombre: json['nombre']?.toString() ?? '',
      descripcion: json['descripcion']?.toString() ?? '',
      // El tipo NUMERIC de Postgres a veces llega como String en JSON
      precio: double.tryParse(json['precio']?.toString() ?? '0') ?? 0.0,
      disponible: json['disponible'] ?? true,
      imagenUrl: json['imagen_url']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nombre': nombre,
      'descripcion': descripcion,
      'precio': precio,
      'disponible': disponible,
      'imagen_url': imagenUrl,
    };
  }

  factory PlatoModel.fromEntity(Plato plato) {
    return PlatoModel(
      id: plato.id,
      nombre: plato.nombre,
      descripcion: plato.descripcion,
      precio: plato.precio,
      disponible: plato.disponible,
      imagenUrl: plato.imagenUrl,
    );
  }
}
