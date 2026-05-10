class ProductoModel {
  final String nombre;
  final double precio;
  final int cantidad;

  ProductoModel({
    required this.nombre,
    required this.precio,
    required this.cantidad,
  });


  double get total => precio * cantidad;
}