import '../model/persona_modelo.dart';

class PersonaController {

  String procesar(List<String> inputs) {
    try {
      if (inputs.length != 10) {
        return "Debe ingresar exactamente 10 pesos";
      }

      final pesos = inputs.map((e) {
        if (e.trim().isEmpty) {
          throw Exception("Campos vacíos");
        }
        return double.parse(e);
      }).toList();

      final r = PersonaModelo.analizar(pesos);

      return '''
        Resultados:
        Promedio: ${r.promedio.toStringAsFixed(2)}
        Último peso: ${r.ultimoPeso.toStringAsFixed(2)}
        Estado: ${r.estado}
        Diferencia: ${r.diferencia.toStringAsFixed(2)} kg
        ''';

    } catch (e) {
      return "Error: $e";
    }
  }
}