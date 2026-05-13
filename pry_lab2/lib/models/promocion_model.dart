class ArticuloModel {
  final String nombre;
  final double precioOriginal;
  late double descuento;
  late double precioFinal;

  ArticuloModel({required this.nombre, required this.precioOriginal}) {
    _calcularDescuento();
  }

  void _calcularDescuento() {
    if (precioOriginal >= 200) {
      descuento = precioOriginal * 0.15;
    } else if (precioOriginal > 100) {
      descuento = precioOriginal * 0.12;
    } else {
      descuento = precioOriginal * 0.10;
    }
    precioFinal = precioOriginal - descuento;
  }
}

class CompraModel {
  final List<ArticuloModel> articulos;

  CompraModel({required this.articulos});

  double calcularTotalPagar() {
    return articulos.fold(0, (total, item) => total + item.precioFinal);
  }

  String generarResumenTexto() {
    if (articulos.isEmpty) return "No hay artículos en la promoción.";

    String resumen = "RESUMEN DE PROMOCIÓN\n";
    resumen += "--------------------------\n";
    resumen += "Total de artículos: ${articulos.length}\n";
    resumen += "TOTAL FINAL A PAGAR: \$${calcularTotalPagar().toStringAsFixed(2)}\n\n";
    resumen += "DETALLE POR ARTÍCULO:";

    return resumen;
  }
}