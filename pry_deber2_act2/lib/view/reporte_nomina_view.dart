import 'package:flutter/material.dart';
import '../controller/nomina_controller.dart';
import '../widgets/atomos/atom_button.dart';
import '../widgets/organismos/org_tarjeta_nomina.dart';

class ReporteNominaView extends StatelessWidget {
  final NominaController controller;

  const ReporteNominaView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    // Si se pasa un reporte por argumentoslo usamos, si no generamos uno nuevo
    final String? reporteArg = ModalRoute.of(context)!.settings.arguments as String?;
    final String reporte = reporteArg ?? controller.obtenerReporteFinal();

    return Scaffold(
      appBar: AppBar(title: const Text("Reporte de Nómina")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OrgTarjetaNomina(
                  titulo: "Información de Nómina",
                  contenido: reporte,
                  destacar: true,
                ),
                const SizedBox(height: 40),
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
      ),
    );
  }
}
