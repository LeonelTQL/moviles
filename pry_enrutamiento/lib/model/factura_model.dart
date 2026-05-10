class ProductoModel {
  final String nombre;
  final double precio;

  ProductoModel(this.nombre, this.precio);
}

class FacturaModel {
  final List<ProductoModel> productos;

  FacturaModel(this.productos);

  double calcularSubtotal() {
    return productos.fold(0, (sum, item) => sum + item.precio);
  }

  double calcularDescuento() {
    double subtotal = calcularSubtotal();
    if (subtotal > 300) {
      return subtotal * 0.20;
    }
    return 0.0;
  }

  double calcularTotal() {
    return calcularSubtotal() - calcularDescuento();
  }
}
