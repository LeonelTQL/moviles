import '../model/ejercicio_model.dart';

class EjercicioController {
  String procesar(String sa, String sb, String sc){
    try{
      final a=int.parse(sa);
      final b=int.parse(sb);
      final c=int.parse(sc);

      final r = EjercicioModelo.calculos(a, b, c);

      return '''
      Resultados:
      Diferentes: ${r.diferentes}
      Suma: ${r.suma}
      Promedio: ${r.promedio}
      Producto: ${r.producto}
      Restante:${r.restante}
      Divisible por 3: ${r.divisionPor ? "SI":"NO"}
      ''';
    }catch(e){
      return "Saramanbiche: $e";
    }
  }

}