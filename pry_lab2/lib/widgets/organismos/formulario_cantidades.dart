import 'package:flutter/material.dart';

import '../atomos/boton_principal_app.dart';
import '../atomos/campo_texto_app.dart';
import '../atomos/tarjeta_base_app.dart';

class FormularioCantidades extends StatelessWidget {
  final TextEditingController cantidadesController;
  final int cantidadIngresada;
  final VoidCallback onCalcular;
  final VoidCallback onLimpiar;

  const FormularioCantidades({
    super.key,
    required this.cantidadesController,
    required this.cantidadIngresada,
    required this.onCalcular,
    required this.onLimpiar,
  });

  @override
  Widget build(BuildContext context) {
    return TarjetaBaseApp(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CampoTextoApp(
            controller: cantidadesController,
            label: 'Cantidades',
            hint: 'Ejemplo: -2, 0, 5, -8, 0, 12',
            keyboardType: const TextInputType.numberWithOptions(
              decimal: true,
              signed: true,
            ),
            icono: Icons.numbers,
            maxLines: 4,
          ),
          const SizedBox(height: 8),
          Text(
            'Cantidades ingresadas: $cantidadIngresada',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 16),
          BotonPrincipalApp(
            texto: 'Contar cantidades',
            icono: Icons.calculate,
            onPressed: onCalcular,
          ),
          const SizedBox(height: 8),
          BotonPrincipalApp(
            texto: 'Limpiar',
            icono: Icons.cleaning_services,
            onPressed: onLimpiar,
          ),
        ],
      ),
    );
  }
}