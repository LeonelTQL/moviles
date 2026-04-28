import '../model/conteo_model.dart';

class conteoController {

  String procesar(List<String> inputs) {
    try {
      final numeros = inputs
          .where((e) => e.trim().isNotEmpty)
          .map((e) {
        final n = int.parse(e);

        if (n < 0) {
          throw Exception("Solo números naturales (>=0)");
        }

        return n;
      }).toList();

      if (numeros.isEmpty) {
        return "Ingrese al menos un número";
      }

      final r = conteoModelo.analizar(numeros);

      return '''
        Resultados:
        Menores que 15: ${r.menores15}
        Mayores que 50: ${r.mayores50}
        Entre 25 y 45: ${r.entre25y45}
        Promedio: ${r.promedio.toStringAsFixed(2)}
        ''';

    } catch (e) {
      return "Error: $e";
    }
  }
}