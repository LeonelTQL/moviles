class HamburguesaModelo {
  // Cantidades ingresadas por el cliente
  final int cantidadSencillas;
  final int cantidadDobles;
  final int cantidadTriples;
  final bool pagoConTarjeta;

  // Precios fijos del menú
  static const double precioSencilla = 20.0;
  static const double precioDoble = 25.0;
  static const double precioTriple = 28.0;

  HamburguesaModelo({
    required this.cantidadSencillas,
    required this.cantidadDobles,
    required this.cantidadTriples,
    required this.pagoConTarjeta,
  });

  // Cálculos de negocio
  double get subtotal =>
      (cantidadSencillas * precioSencilla) +
          (cantidadDobles * precioDoble) +
          (cantidadTriples * precioTriple);

  // Solo se aplica el 5% (0.05) si el pago es con tarjeta
  double get cargoTarjeta => pagoConTarjeta ? subtotal * 0.05 : 0.0;

  double get total => subtotal + cargoTarjeta;
}