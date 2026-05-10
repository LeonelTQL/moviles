import 'package:flutter/material.dart';
import '../widgets/atomos/atom_button.dart';
import '../widgets/organismos/org_tarjeta_info.dart';

class ResultadoView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final datos = ModalRoute.of(context)!.settings.arguments as Map<String, String>?;

    if (datos == null || datos.containsKey('error')) {
      return Scaffold(
        appBar: AppBar(title: Text("Error")),
        body: Center(child: Text(datos?['error'] ?? "Error desconocido.")),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text("Resumen de Operación")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            OrgTarjetaInfo(
              titulo: "Factura del Cliente",
              contenido: datos['factura']!,
              colorFondo: Colors.blue[50],
            ),
            SizedBox(height: 20),
            OrgTarjetaInfo(
              titulo: "Sueldo del Vendedor",
              contenido: datos['sueldo']!,
              colorFondo: Colors.green[50],
            ),
            SizedBox(height: 40),
            AtomButton(
                label: "Volver (Pop)",
                onPressed: () {
                  Navigator.pop(context); // Regresa a la pantalla anterior
                }
            ),
          ],
        ),
      ),
    );
  }
}