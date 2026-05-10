import '../model/vuelto_model.dart';

class VueltoController {
  String procesar(String precioStr, String pagoStr) {
    try {
      final precio = double.parse(precioStr);
      final pago = double.parse(pagoStr);

      if (precio <= 0 || pago <= 0) {
        return "Los valores deben ser mayores a cero.";
      }

      // El modelo hace todo el trabajo matemático
      final r = VueltoModelo.calcular(precio, pago);

      if (r.vueltoTotal == 0) {
        return "No hay vuelto. El pago fue exacto.";
      }

      return '''
      Vuelto Total: \$${r.vueltoTotal.toStringAsFixed(2)}
      -----------------------------
      Monedas de \$2: ${r.monedas2}
      Monedas de \$1: ${r.monedas1}
      Monedas de \$0.50: ${r.monedas50}
      Monedas de \$0.25: ${r.monedas25}
      Monedas de \$0.10: ${r.monedas10}
      ''';

    } catch (e) {
      if (e.toString().contains("PagoInsuficiente")) {
        return "El dinero entregado no alcanza para pagar el artículo.";
      }
      return "Por favor, ingrese valores numéricos válidos.";
    }
  }
}