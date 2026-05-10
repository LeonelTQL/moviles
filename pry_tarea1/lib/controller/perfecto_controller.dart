import '../model/perfecto_model.dart';

class perfectoController {
  final _model = perfectoModel();

  String verificarPerfecto(String input) {
    int? n = int.tryParse(input);

    if (n == null || n <= 0) {
      return "Ingrese un número válido";
    }

    bool resultado = _model.esPerfecto(n);

    if (resultado) {
      return "El número $n es perfecto";
    } else {
      return "El número $n no es perfecto";
    }
  }
}