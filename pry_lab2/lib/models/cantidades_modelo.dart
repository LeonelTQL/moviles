class ResultadoCantidadesModelo {
  final int totalCantidades;
  final int ceros;
  final int menoresACero;
  final int mayoresACero;

  const ResultadoCantidadesModelo({
    required this.totalCantidades,
    required this.ceros,
    required this.menoresACero,
    required this.mayoresACero,
  });
}

class CantidadesModelo {
  final List<double> cantidades;

  const CantidadesModelo({required this.cantidades});

  ResultadoCantidadesModelo calcularConteo() {
    int ceros = 0;
    int menoresACero = 0;
    int mayoresACero = 0;

    for (final double cantidad in cantidades) {
      if (cantidad == 0) {
        ceros++;
      } else if (cantidad < 0) {
        menoresACero++;
      } else {
        mayoresACero++;
      }
    }

    return ResultadoCantidadesModelo(
      totalCantidades: cantidades.length,
      ceros: ceros,
      menoresACero: menoresACero,
      mayoresACero: mayoresACero,
    );
  }
}
