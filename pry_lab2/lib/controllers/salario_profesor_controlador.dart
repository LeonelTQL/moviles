import '../models/salario_profesor_modelo.dart';
import 'respuesta_controlador.dart';

class SalarioProfesorControlador {
  static const double _salarioInicialMaximo = 1000000;
  static const double _porcentajeIncrementoMaximo = 100;
  static const int _aniosMaximos = 100;
  static const double _montoCalculadoMaximo = 1000000000;

  RespuestaControlador<ResultadoSalarioProfesorModelo> procesar({
    required String salarioInicialTexto,
    required String porcentajeIncrementoTexto,
    required String aniosTexto,
  }) {
    final double? salarioInicial = _convertirDouble(salarioInicialTexto);
    final double? porcentajeIncremento = _convertirDouble(
      porcentajeIncrementoTexto,
    );
    final int? anios = int.tryParse(aniosTexto.trim());

    if (salarioInicialTexto.trim().isEmpty ||
        porcentajeIncrementoTexto.trim().isEmpty ||
        aniosTexto.trim().isEmpty) {
      return const RespuestaControlador.error('Complete todos los campos.');
    }

    if (salarioInicial == null || !salarioInicial.isFinite) {
      return const RespuestaControlador.error(
        'Ingrese un salario inicial válido.',
      );
    }

    if (salarioInicial <= 0) {
      return const RespuestaControlador.error(
        'El salario inicial debe ser mayor a 0.',
      );
    }

    if (salarioInicial > _salarioInicialMaximo) {
      return const RespuestaControlador.error(
        'El salario inicial no puede ser mayor a \$1,000,000.',
      );
    }

    if (porcentajeIncremento == null || !porcentajeIncremento.isFinite) {
      return const RespuestaControlador.error(
        'Ingrese un porcentaje de incremento válido.',
      );
    }

    if (porcentajeIncremento < 0) {
      return const RespuestaControlador.error(
        'El porcentaje no puede ser negativo.',
      );
    }

    if (porcentajeIncremento > _porcentajeIncrementoMaximo) {
      return const RespuestaControlador.error(
        'El porcentaje de incremento no puede ser mayor a 100%.',
      );
    }

    if (anios == null) {
      return const RespuestaControlador.error(
        'Ingrese un número de años válido.',
      );
    }

    if (anios <= 0) {
      return const RespuestaControlador.error(
        'El número de años debe ser mayor a 0.',
      );
    }

    if (anios > _aniosMaximos) {
      return const RespuestaControlador.error(
        'El número de años no puede ser mayor a 100.',
      );
    }

    if (_calculoEsDemasiadoGrande(
      salarioInicial: salarioInicial,
      porcentajeIncremento: porcentajeIncremento,
      anios: anios,
    )) {
      return const RespuestaControlador.error(
        'Con esos valores el cálculo genera cantidades demasiado grandes.',
      );
    }

    final modelo = SalarioProfesorModelo(
      salarioInicial: salarioInicial,
      porcentajeIncremento: porcentajeIncremento,
      anios: anios,
    );

    return RespuestaControlador.exito(modelo.calcularSalarios());
  }

  double? _convertirDouble(String texto) {
    return double.tryParse(texto.trim().replaceAll(',', '.'));
  }

  bool _calculoEsDemasiadoGrande({
    required double salarioInicial,
    required double porcentajeIncremento,
    required int anios,
  }) {
    double salarioActual = salarioInicial;
    double totalRecibido = 0;

    for (int i = 1; i <= anios; i++) {
      final double incremento = salarioActual * (porcentajeIncremento / 100);
      salarioActual += incremento;
      totalRecibido += salarioActual;

      if (!salarioActual.isFinite ||
          !totalRecibido.isFinite ||
          salarioActual > _montoCalculadoMaximo ||
          totalRecibido > _montoCalculadoMaximo) {
        return true;
      }
    }

    return false;
  }
}
