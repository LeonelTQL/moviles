import 'package:flutter/material.dart';
import '../widgets/atomos/atom_button.dart';
import '../widgets/organismos/org_tarjeta_resumen.dart';

class ResumenPagoView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final resultado = ModalRoute.of(context)!.settings.arguments as String?;

    return Scaffold(
      appBar: AppBar(title: Text("Resumen de Transacción")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OrgTarjetaResumen(contenidoFactura: resultado ?? "No hay datos."),

              SizedBox(height: 40),

              AtomButton(
                label: "Volver a Inicio",
                onPressed: () {
                  Navigator.popUntil(context, ModalRoute.withName('/menu'));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}