import '../model/chofer_model.dart';

class NominaController {
  final List<Chofer> _listaChoferes = [];

  List<Chofer> get listaChoferes => _listaChoferes;

  String registrarChofer({
    required String nombre,
    required List<String> horasString,
    required String sueldoString,
    required bool activo,
    required bool bono,
    required String jornada,
  }) {
    if (_listaChoferes.length >= 5) return "Error: Máximo 5 choferes.";
    if (nombre.isEmpty || sueldoString.isEmpty) return "Error: Datos incompletos.";
    
    final sueldo = double.tryParse(sueldoString) ?? 0.0;
    if (sueldo < 0) return "Error: El sueldo no puede ser negativo.";
    
    List<double> horas = [];

    for (String h in horasString) {
      double valor = double.tryParse(h) ?? 0.0;
      if (valor > 24 || valor < 0 ) return "Error: Horas inválidas.";
      horas.add(valor);
    }

    _listaChoferes.add(Chofer(
      nombre: nombre,
      horasDiarias: horas,
      sueldoPorHora: sueldo,
      estaActivo: activo,
      recibeBono: bono,
      jornada: jornada,
    ));

    return "Éxito: Chofer registrado";
  }

  String obtenerReporteFinal() {
    final nomina = NominaModel(choferes: _listaChoferes);
    return nomina.generarReporteTexto();
  }
}
