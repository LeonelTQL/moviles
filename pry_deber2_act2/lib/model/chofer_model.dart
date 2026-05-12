class Chofer {
  final String nombre;
  final List<double> horasDiarias;
  final double sueldoPorHora;
  final bool estaActivo;
  final bool recibeBono;
  final String jornada;

  Chofer({
    required this.nombre,
    required this.horasDiarias,
    required this.sueldoPorHora,
    required this.estaActivo,
    required this.recibeBono,
    required this.jornada,
  });

  double calcularTotalHoras() => horasDiarias.fold(0, (a, b) => a + b);

  double calcularSueldoSemanal() {
    double base = calcularTotalHoras() * sueldoPorHora;
    return recibeBono ? base + 50.0 : base;
  }
}

class NominaModel {
  final List<Chofer> choferes;

  NominaModel({required this.choferes});

  double calcularTotalEmpresa() {
    return choferes.fold(0, (total, chofer) => total + chofer.calcularSueldoSemanal());
  }

  String obtenerChoferMasHorasLunes() {
    if (choferes.isEmpty) return "No se registraron choferes";
    Chofer destacado = choferes.first;
    for (var chofer in choferes) {
      if (chofer.horasDiarias[0] > destacado.horasDiarias[0]) {
        destacado = chofer;
      }
    }
    return destacado.nombre;
  }


  String generarReporteTexto() {
    if (choferes.isEmpty) return "No se han registrado choferes.";

    String reporte = "REPORTE GENERAL DE LA EMPRESA\n";
    reporte += "--------------------------------\n";
    reporte += "Total general a pagar: \$${calcularTotalEmpresa().toStringAsFixed(2)}\n";
    reporte += "Chofer destacado Lunes: ${obtenerChoferMasHorasLunes()}\n\n";
    reporte += "--------------------------------\n";
    reporte += "DETALLE POR CHOFER:\n";
    for (var c in choferes) {
      reporte += "\nChofer: ${c.nombre} ${c.estaActivo ? '(Activo)' : '(Inactivo)'}\n";
      reporte += "Jornada: ${c.jornada}\n";
      reporte += "Horas totales: ${c.calcularTotalHoras()} hrs\n";
      reporte += "Sueldo Semanal: \$${c.calcularSueldoSemanal().toStringAsFixed(2)}\n";
    }
    return reporte;
  }
}