import 'package:flutter/material.dart';

import '../atomos/boton_principal_app.dart';
import '../atomos/campo_texto_app.dart';
import '../atomos/tarjeta_base_app.dart';

class FormularioSalarioProfesor extends StatelessWidget {
  final TextEditingController salarioInicialController;
  final TextEditingController porcentajeIncrementoController;
  final TextEditingController aniosController;
  final VoidCallback onCalcular;
  final VoidCallback onLimpiar;

  const FormularioSalarioProfesor({
    super.key,
    required this.salarioInicialController,
    required this.porcentajeIncrementoController,
    required this.aniosController,
    required this.onCalcular,
    required this.onLimpiar,
  });

  @override
  Widget build(BuildContext context) {
    return TarjetaBaseApp(
      child: Column(
        children: [
          CampoTextoApp(
            controller: salarioInicialController,
            label: 'Salario inicial',
            hint: 'Ejemplo: 1500',
            keyboardType: TextInputType.number,
            icono: Icons.attach_money,
          ),
          const SizedBox(height: 12),
          CampoTextoApp(
            controller: porcentajeIncrementoController,
            label: 'Incremento anual (%)',
            hint: 'Ejemplo: 10',
            keyboardType: TextInputType.number,
            icono: Icons.percent,
          ),
          const SizedBox(height: 12),
          CampoTextoApp(
            controller: aniosController,
            label: 'Número de años',
            hint: 'Ejemplo: 6',
            keyboardType: TextInputType.number,
            icono: Icons.calendar_month,
          ),
          const SizedBox(height: 16),
          BotonPrincipalApp(
            texto: 'Calcular salario',
            icono: Icons.calculate,
            onPressed: onCalcular,
          ),
          const SizedBox(height: 16),
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
