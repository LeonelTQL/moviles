import '../models/cantidades_modelo.dart';
import 'respuesta_controlador.dart';

class CantidadesControlador {
  static const int maximoCantidadesPermitidas = 100;

  RespuestaControlador<ResultadoCantidadesModelo> procesar({
    required String cantidadesTexto,
  }) {
    if (cantidadesTexto.trim().isEmpty) {
      return const RespuestaControlador.error(
        'Ingrese al menos una cantidad.',
      );
    }

    final List<String> partes = cantidadesTexto
        .split(RegExp(r'[\s,;]+'))
        .where((valor) => valor.trim().isNotEmpty)
        .toList();

    if (partes.isEmpty) {
      return const RespuestaControlador.error(
        'Ingrese al menos una cantidad válida.',
      );
    }

    if (partes.length > maximoCantidadesPermitidas) {
      return const RespuestaControlador.error(
        'No puede ingresar más de 100 cantidades.',
      );
    }

    final List<double> cantidades = [];

    for (final String parte in partes) {
      if (parte.length > 12) {
        return RespuestaControlador.error(
          'El valor "$parte" es demasiado grande.',
        );
      }

      final double? numero = double.tryParse(
        parte.trim().replaceAll(',', '.'),
      );

      if (numero == null) {
        return RespuestaControlador.error(
          'El valor "$parte" no es una cantidad válida.',
        );
      }

      if (numero.abs() > 1000000) {
        return RespuestaControlador.error(
          'El valor "$parte" supera el límite permitido de 1000000.',
        );
      }

      cantidades.add(numero);
    }

    final modelo = CantidadesModelo(
      cantidades: cantidades,
    );

    return RespuestaControlador.exito(
      modelo.calcularConteo(),
    );
  }
}