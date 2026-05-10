import '../model/factura_model.dart';

class FacturaController {
  
  String? validarYAgregar(String nombre, String precioStr, List<ProductoModel> productos) {
    if (nombre.isEmpty) return "El nombre no puede estar vacío";
    
    final precio = double.tryParse(precioStr);
    if (precio == null || precio <= 0) {
      return "Ingrese un precio válido";
    }

    productos.add(ProductoModel(nombre, precio));
    return null; // Éxito
  }

  Map<String, double> procesarFactura(List<ProductoModel> productos) {
    final factura = FacturaModel(productos);
    return {
      'subtotal': factura.calcularSubtotal(),
      'descuento': factura.calcularDescuento(),
      'total': factura.calcularTotal(),
    };
  }
}
