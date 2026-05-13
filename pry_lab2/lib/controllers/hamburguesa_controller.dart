import '../models/hamburguesa_model.dart';

class HamburguesaController {

  String procesarPedido(String cantS, String cantD, String cantT, bool conTarjeta) {
    try {
      // Parseamos los valores. Si el campo está vacío, asumimos que es 0.
      final s = cantS.isEmpty ? 0 : int.parse(cantS);
      final d = cantD.isEmpty ? 0 : int.parse(cantD);
      final t = cantT.isEmpty ? 0 : int.parse(cantT);

      if (s < 0 || d < 0 || t < 0) {
        return "Las cantidades no pueden ser negativas.";
      }

      if (s == 0 && d == 0 && t == 0) {
        return "Debe pedir al menos una hamburguesa para cobrar.";
      }

      // El modelo se encarga de las matemáticas
      final modelo = HamburguesaModelo(
        cantidadSencillas: s,
        cantidadDobles: d,
        cantidadTriples: t,
        pagoConTarjeta: conTarjeta,
      );

      // Retornamos el resultado formateado
      return '''
      🍔 TICKET DE COMPRA 🍔
      --------------------------------
      Sencillas ($s): \$${(s * HamburguesaModelo.precioSencilla).toStringAsFixed(2)}
      Dobles ($d): \$${(d * HamburguesaModelo.precioDoble).toStringAsFixed(2)}
      Triples ($t): \$${(t * HamburguesaModelo.precioTriple).toStringAsFixed(2)}
      --------------------------------
      Subtotal: \$${modelo.subtotal.toStringAsFixed(2)}
      Cargo Tarjeta (5%): \$${modelo.cargoTarjeta.toStringAsFixed(2)}
      
      TOTAL A PAGAR: \$${modelo.total.toStringAsFixed(2)}
      ''';

    } catch (e) {
      return "Error: Ingrese solo números enteros válidos.";
    }
  }
}