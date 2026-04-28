import '../model/edad_model.dart';

class EdadController {
  String procesarEdad(String d, String m, String a){
    if(d.isEmpty || m.isEmpty || a.isEmpty){
      return 'ingresar fecha valida';
    }

    int? dia = int.tryParse(d);
    int? mes = int.tryParse(m);
    int? anio = int.tryParse(a);

    if (dia ==null || mes==null || anio ==null){
      return 'ingresar fecha valida';
    }

    if (dia<=0 || dia >31||mes<=0 || mes >12||anio<=0){
      return 'ingresar fecha valida';
    }

    final r= EdadModel.calcularEdad(dia,mes,anio);

    return 'Tienes ${r["anios"]} años, ${r["meses"]} meses y ${r["dias"]} dias';
  }
}