import '../model/caja_model.dart';

class CajaController {
  // Instanciamos el modelo para mantener el estado de la caja
  final CajaModelo _modelo = CajaModelo();

  String procesarArticulo(String precioStr) {
    try {
      final precio = double.parse(precioStr);
      if (precio <= 0) return "El precio debe ser mayor a cero.";

      _modelo.agregarArticulo(precio);
      return "Subtotal cliente actual: \$${_modelo.totalClienteActual.toStringAsFixed(2)}";
    } catch (e) {
      return "Por favor, ingrese un valor numérico válido.";
    }
  }

  String procesarFinCliente() {
    if (_modelo.totalClienteActual == 0) {
      return "No hay artículos ingresados para este cliente.";
    }

    final total = _modelo.cerrarCobroCliente();
    return "✅ COBRO EXITOSO\nEl cliente debe pagar: \$${total.toStringAsFixed(2)}";
  }

  String procesarReporteSupervisor() {
    return '''
    📊 REPORTE DE FIN DE DÍA (SUPERVISOR)
    Total recaudado: \$${_modelo.totalCajaDia.toStringAsFixed(2)}
    Clientes atendidos: ${_modelo.clientesAtendidos}
    ''';
  }
}