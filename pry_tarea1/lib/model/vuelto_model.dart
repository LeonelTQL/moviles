class VueltoModelo {
  final double vueltoTotal;
  final int monedas2;
  final int monedas1;
  final int monedas50;
  final int monedas25;
  final int monedas10;

  // Constructor
  VueltoModelo({
    required this.vueltoTotal,
    required this.monedas2,
    required this.monedas1,
    required this.monedas50,
    required this.monedas25,
    required this.monedas10,
  });

  // Operaciones de cálculo
  static VueltoModelo calcular(double precio, double pago) {
    if (pago < precio) {
      throw Exception("PagoInsuficiente");
    }

    final vuelto = pago - precio;

    // Multiplicamos por 100 y redondeamos para trabajar con enteros exactos (centavos)
    int centavos = (vuelto * 100).round();

    // Calculamos cantidad de monedas empezando por la más grande (algoritmo voraz)
    final m2 = centavos ~/ 200; // Monedas de $2
    centavos %= 200;

    final m1 = centavos ~/ 100; // Monedas de $1
    centavos %= 100;

    final m50 = centavos ~/ 50; // Monedas de $0.50
    centavos %= 50;

    final m25 = centavos ~/ 25; // Monedas de $0.25
    centavos %= 25;

    final m10 = centavos ~/ 10; // Monedas de $0.10
    centavos %= 10;

    return VueltoModelo(
      vueltoTotal: vuelto,
      monedas2: m2,
      monedas1: m1,
      monedas50: m50,
      monedas25: m25,
      monedas10: m10,
    );
  }
}