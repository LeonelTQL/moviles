import 'package:flutter/material.dart';
import '../widgets/atomos/boton_principal_app.dart';
import '../widgets/organismos/org_tarjeta_info.dart';

class ResultadoView extends StatelessWidget {
  const ResultadoView({super.key});

  @override
  Widget build(BuildContext context) {
    final datos = ModalRoute.of(context)!.settings.arguments as Map<String, String>?;

    if (datos == null || datos.containsKey('error')) {
      return Scaffold(
        appBar: AppBar(title: const Text("Error")),
        body: Center(child: Text(datos?['error'] ?? "Error desconocido.")),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Resumen de Operación")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            OrgTarjetaInfo(
              titulo: "Factura del Cliente",
              contenido: datos['factura']!,
              colorFondo: Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.3),
            ),
            const SizedBox(height: 20),
            OrgTarjetaInfo(
              titulo: "Sueldo del Vendedor",
              contenido: datos['sueldo']!,
              colorFondo: Theme.of(context).colorScheme.secondaryContainer.withValues(alpha: 0.3),
            ),
            const SizedBox(height: 40),
            BotonPrincipalApp(
                texto: "Volver al Menú",
                icono: Icons.home,
                onPressed: () {
                  Navigator.pop(context);
                }
            ),
          ],
        ),
      ),
    );
  }
}