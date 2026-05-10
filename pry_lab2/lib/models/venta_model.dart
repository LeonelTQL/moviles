import 'producto_model.dart';

class VentaModel {
  final String cliente;
  final String vendedor;
  final List<ProductoModel> productos;

  final double sueldoBaseVendedor = 400.0;
  final double porcentajeComision = 0.10;

  VentaModel({
    required this.cliente,
    required this.vendedor,
    required this.productos,
  });


  double calcularSubtotalBruto() {
    double total = 0;
    for (var producto in productos) {
      total += producto.total;
    }
    return total;
  }

  double calcularDescuento() {
    final bruto = calcularSubtotalBruto();
    if (bruto > 2000) {
      return bruto * 0.20;
    }
    return 0.0;
  }

  double calcularSubtotalNeto() => calcularSubtotalBruto() - calcularDescuento();

  double calcularIva() => calcularSubtotalNeto() * 0.15; // IVA 15%

  double calcularTotalFactura() => calcularSubtotalNeto() + calcularIva();

  double calcularComision() => calcularSubtotalBruto() * porcentajeComision;

  double calcularSueldoFinal() => sueldoBaseVendedor + calcularComision();
}