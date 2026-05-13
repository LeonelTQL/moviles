import 'package:flutter/material.dart';

import '../../models/salario_profesor_modelo.dart';
import '../atomos/tarjeta_base_app.dart';
import '../moleculas/item_resultado.dart';

class ResultadoSalarioProfesor extends StatelessWidget {
  final ResultadoSalarioProfesorModelo resultado;

  const ResultadoSalarioProfesor({
    super.key,
    required this.resultado,
  });

  String _moneda(double valor) => '\$${valor.toStringAsFixed(2)}';

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
            etiqueta: 'Salario inicial',
            valor: _moneda(resultado.salarioInicial),
            icono: Icons.payments,
          ),
          ItemResultado(
            etiqueta: 'Incremento anual',
            valor: '${resultado.porcentajeIncremento.toStringAsFixed(2)}%',
            icono: Icons.trending_up,
          ),
          ItemResultado(
            etiqueta: 'Salario al cabo de ${resultado.anios} años',
            valor: _moneda(resultado.salarioFinal),
            icono: Icons.flag,
          ),
          ItemResultado(
            etiqueta: 'Total recibido en ${resultado.anios} años',
            valor: _moneda(resultado.totalRecibido),
            icono: Icons.summarize,
          ),
          const Divider(height: 28),
          Text(
            'Detalle por año',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          ...resultado.detalleAnual.map(
            (detalle) => ItemResultado(
              etiqueta:
                  'Año ${detalle.anio} | incremento ${_moneda(detalle.incremento)}',
              valor: _moneda(detalle.salario),
            ),
          ),
        ],
      ),
    );
  }
}
