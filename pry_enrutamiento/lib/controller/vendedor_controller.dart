import '../model/vendedor_model.dart';


class VendedorController {
  String calcularSueldo(String s1, String s2, String s3){


    if(s1.isEmpty || s2.isEmpty || s3.isEmpty){
      return "Ta vacio algo ";
    }

    final v1 = double.tryParse(s1);
    final v2 = double.tryParse(s2);
    final v3 = double.tryParse(s3);

    if(v1== null || v2== null || v3== null){
      return "Numero only";
    }
    
    final vendedor = VendedorModel(v1, v2, v3);
    final sueldo = vendedor.calcularSueldo();
    
    
    
    return "El sueldo es: \$${sueldo.toStringAsFixed(2)}";
  }
}