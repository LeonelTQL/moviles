import 'package:flutter/material.dart';
import '../models/promocion_model.dart';
import '../widgets/atomos/boton_principal_app.dart';
import '../widgets/organismos/org_cotizacion.dart';

class ReportePromocionView extends StatelessWidget {
  const ReportePromocionView({super.key});

  @override
  Widget build(BuildContext context) {
    final compra = ModalRoute.of(context)!.settings.arguments as CompraModel;

    return Scaffold(
      appBar: AppBar(title: const Text("Cotización de Compra")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Resumen General usando OrgCotizacion
            OrgCotizacion(
              titulo: "Total de la Cotización",
              contenido: compra.generarResumenTexto(),
              destacar: true,
            ),

            const SizedBox(height: 20),

            // Detalle de cada artículo usando OrgCotizacion
            Expanded(
              child: ListView.builder(
                itemCount: compra.articulos.length,
                itemBuilder: (context, index) {
                  final item = compra.articulos[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: OrgCotizacion(
                      titulo: "Artículo: ${item.nombre}",
                      contenido: "Precio Base: \$${item.precioOriginal.toStringAsFixed(2)}\n"
                          "Descuento Aplicado: \$${item.descuento.toStringAsFixed(2)}\n"
                          "Costo con Promoción: \$${item.precioFinal.toStringAsFixed(2)}",
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 16),

            BotonPrincipalApp(
              texto: "Nueva Cotización",
              icono: Icons.refresh,
              onPressed: () => Navigator.pop(context),
            )
          ],
        ),
      ),
    );
  }
}