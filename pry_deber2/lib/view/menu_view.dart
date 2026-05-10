import 'package:flutter/material.dart';
import '../widgets/atomos/atom_label.dart';
import '../widgets/atomos/atom_button.dart';

class MenuView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Inicio")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AtomLabel(text: "Sistema de Pagos de Servicios", isTitle: true),
            SizedBox(height: 30),
            AtomButton(
              label: "Registrar Nuevo Pago",
              onPressed: () {
                Navigator.pushNamed(context, '/registro');
              },
            ),
          ],
        ),
      ),
    );
  }
}