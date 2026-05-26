// recibir datos desde la UI
//mandar datos USECASE
//Guarda el resultado
//Notifica a la UI
import 'package:flutter/material.dart';
import '../../domain/entities/resultado_operario.dart';
import '../../domain/entities/operario.dart';
import '../../domain/usecases/calcular_aumento_usecase.dart';
class OperarioViewmodel extends ChangeNotifier {
  final CalcularAumentoUsecase _UseCase;

  OperarioViewmodel(this._UseCase);
  ResultadoOperario? resultadoOperario;
  ResultadoOperario calcular(double sueldo, double antiguedad){
    final op = Operario(sueldo: sueldo, antiguedad: antiguedad);
    resultadoOperario = _UseCase.ejecutar(op);
    notifyListeners();
    return resultadoOperario!;
  }
}
