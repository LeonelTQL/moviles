import 'package:flutter/material.dart';

import '../../models/cantidades_modelo.dart';
import '../atomos/tarjeta_base_app.dart';
import '../moleculas/item_resultado.dart';

class ResultadoCantidades extends StatelessWidget {
  final ResultadoCantidadesModelo resultado;

  const ResultadoCantidades({
    super.key,
    required this.resultado,
  });

  @override
  Widget build(BuildContext context) {
    return TarjetaBaseApp(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Resultado',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          ItemResultado(
            etiqueta: 'Total de cantidades ingresadas',
            valor: resultado.totalCantidades.toString(),
            icono: Icons.list,
          ),
          ItemResultado(
            etiqueta: 'Cantidades iguales a cero',
            valor: resultado.ceros.toString(),
            icono: Icons.exposure_zero,
          ),
          ItemResultado(
            etiqueta: 'Cantidades menores a cero',
            valor: resultado.menoresACero.toString(),
            icono: Icons.arrow_downward,
          ),
          ItemResultado(
            etiqueta: 'Cantidades mayores a cero',
            valor: resultado.mayoresACero.toString(),
            icono: Icons.arrow_upward,
          ),
        ],
      ),
    );
  }
}
