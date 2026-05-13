class DetalleSalarioModelo {
  final int anio;
  final double incremento;
  final double salario;

  const DetalleSalarioModelo({
    required this.anio,
    required this.incremento,
    required this.salario,
  });
}

class ResultadoSalarioProfesorModelo {
  final double salarioInicial;
  final double porcentajeIncremento;
  final int anios;
  final double salarioFinal;
  final double totalRecibido;
  final List<DetalleSalarioModelo> detalleAnual;

  const ResultadoSalarioProfesorModelo({
    required this.salarioInicial,
    required this.porcentajeIncremento,
    required this.anios,
    required this.salarioFinal,
    required this.totalRecibido,
    required this.detalleAnual,
  });
}

class SalarioProfesorModelo {
  final double salarioInicial;
  final double porcentajeIncremento;
  final int anios;

  const SalarioProfesorModelo({
    required this.salarioInicial,
    required this.porcentajeIncremento,
    required this.anios,
  });

  ResultadoSalarioProfesorModelo calcularSalarios() {
    double salarioActual = salarioInicial;
    double totalRecibido = 0;
    final List<DetalleSalarioModelo> detalle = [];

    for (int i = 1; i <= anios; i++) {
      final double incremento = salarioActual * (porcentajeIncremento / 100);
      salarioActual += incremento;
      totalRecibido += salarioActual;

      detalle.add(
        DetalleSalarioModelo(
          anio: i,
          incremento: incremento,
          salario: salarioActual,
        ),
      );
    }

    return ResultadoSalarioProfesorModelo(
      salarioInicial: salarioInicial,
      porcentajeIncremento: porcentajeIncremento,
      anios: anios,
      salarioFinal: salarioActual,
      totalRecibido: totalRecibido,
      detalleAnual: detalle,
    );
  }
}
