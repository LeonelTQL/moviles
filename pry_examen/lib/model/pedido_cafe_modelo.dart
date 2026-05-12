class PedidoCafeModelo {

  String cliente;
  String producto;
  String tamano;
  int cantidad;

  double subtotal = 0;
  double iva = 0;
  double total = 0;

  PedidoCafeModelo({
    required this.cliente,
    required this.producto,
    required this.tamano,
    required this.cantidad,
  }) {

    double precioBase = 0;
    double adicionalTamano = 0;

    switch (producto) {

      case "Café":
        precioBase = 1.50;
        break;

      case "Capuchino":
        precioBase = 2.50;
        break;

      case "Chocolate":
        precioBase = 3.00;
        break;

      default:
        throw Exception("Producto no válido");
    }

    switch (tamano) {

      case "Pequeño":
        adicionalTamano = 0.00;
        break;

      case "Mediano":
        adicionalTamano = 0.50;
        break;

      case "Grande":
        adicionalTamano = 1.00;
        break;

      default:
        throw Exception("Tamaño no válido");
    }

    double precioFinal = precioBase + adicionalTamano;

    subtotal = precioFinal * cantidad;
    iva = subtotal * 0.15;
    total = subtotal + iva;
  }
}