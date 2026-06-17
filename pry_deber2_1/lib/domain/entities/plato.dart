class Plato {
  final int? id;
  final String nombre;
  final String descripcion;
  final double precio;
  final bool disponible;
  final String imagenUrl;

  Plato({
    this.id,
    required this.nombre,
    required this.descripcion,
    required this.precio,
    required this.disponible,
    required this.imagenUrl,
  });
}
