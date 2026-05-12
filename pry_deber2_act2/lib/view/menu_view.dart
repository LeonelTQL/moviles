import 'package:flutter/material.dart';
import '../controller/nomina_controller.dart';
import '../widgets/atomos/atom_label.dart';
import '../widgets/atomos/atom_button.dart';

class MenuView extends StatelessWidget {
  final NominaController controller;

  const MenuView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Inicio")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const AtomLabel(text: "Aplicaciones Móviles", isTitle: true),
            const SizedBox(height: 40),
            AtomButton(
              label: "Registro de Choferes",
              isPrimary: true,
              onPressed: () {
                Navigator.pushNamed(context, '/registroNomina');
              },
            ),
            const SizedBox(height: 10),
            AtomButton(
              label: "Nómina de Choferes",
              isPrimary: true,
              onPressed: () {
                Navigator.pushNamed(context, '/reporteNomina');
              },
            ),
          ],
        ),
      ),
    );
  }
}
