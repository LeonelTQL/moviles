import '../model/bisiesto_model.dart';

class BisiestoController {
  String procesar(String sanio) {
    try {
      final anio = int.parse(sanio);

      if (anio <= 0) {
        return 'Error: Por favor ingrese un año válido.';
      }

      final r = BisiestoModel().esBisiesto(anio);

      return '''
      Resultados:

      Año ingresado: ${anio}

      Resultado: ${r ? "Sí es un año bisiesto" : "No es un año bisiesto"}

      Regla aplicada:
      Un año es bisiesto si es múltiplo de 4, excepto los múltiplos de 100, salvo que también sean múltiplos de 400.
      ''';
    } catch (e) {
      return 'Error: Por favor ingrese un año válido.';
    }
  }
}