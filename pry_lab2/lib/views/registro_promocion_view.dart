import 'package:flutter/material.dart';
import '../controllers/promocion_controller.dart';
import '../widgets/atomos/boton_principal_app.dart';
import '../widgets/moleculas/mol_input.dart';
import '../widgets/moleculas/encabezado_ejercicio.dart';

class RegistroPromocionView extends StatefulWidget {
  const RegistroPromocionView({super.key});

  @override
  State<RegistroPromocionView> createState() => _RegistroPromocionViewState();
}

class _RegistroPromocionViewState extends State<RegistroPromocionView> {
  // Instancia del controlador para manejar la lógica de la lista
  final _controller = PromocionController();

  final _nombreInput = TextEditingController();
  final _precioInput = TextEditingController();

  void _anadirArticulo() {
    final mensaje = _controller.agregarArticulo(_nombreInput.text, _precioInput.text);

    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(mensaje))
    );

    if (mensaje.startsWith("Éxito")) {
      _nombreInput.clear();
      _precioInput.clear();
      setState(() {}); // Refresca el contador de artículos en pantalla
    }
  }

  void _irACotizacion() {
    final compra = _controller.obtenerCompraFinal();
    // Requisito técnico: Enviar el objeto como argumento de la ruta
    Navigator.pushNamed(context, '/reporte_articulos', arguments: compra);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Registro de Artículos")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const EncabezadoEjercicio(
              titulo: 'Descuento por Artículos', 
              descripcion: 'Registre los artículos para calcular los descuentos correspondientes según su nombre.'
            ),
            const SizedBox(height: 16),
            MolInput(controller: _nombreInput, label: "Nombre del Artículo"),
            const SizedBox(height: 16),
            MolInput(
                controller: _precioInput,
                label: "Precio Original (\$)",
                keyboardType: TextInputType.number
            ),

            const SizedBox(height: 24),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _anadirArticulo, 
                    icon: const Icon(Icons.add),
                    label: const Text("Añadir"),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: BotonPrincipalApp(
                    texto: "Cotizar Todo", 
                    icono: Icons.payments,
                    onPressed: _irACotizacion
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),
            const Divider(),
            Text(
              "Artículos Agregados:",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            Expanded(
              child: _controller.obtenerCompraFinal().articulos.isEmpty
                  ? const Center(child: Text("No hay artículos agregados todavía."))
                  : ListView.builder(
                itemCount: _controller.obtenerCompraFinal().articulos.length,
                itemBuilder: (context, index) {
                  final articulo = _controller.obtenerCompraFinal().articulos[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                        child: Icon(Icons.article, color: Theme.of(context).colorScheme.primary),
                      ),
                      title: Text(articulo.nombre, style: const TextStyle(fontWeight: FontWeight.bold)),
                      trailing: Text("\$${articulo.precioOriginal.toStringAsFixed(2)}", 
                        style: TextStyle(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.bold)),
                    ),
                  );
                },
              ),
            ),

            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondaryContainer,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total artículos:",
                    style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onSecondaryContainer),
                  ),
                  Text(
                    "${_controller.obtenerCompraFinal().articulos.length}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Theme.of(context).colorScheme.onSecondaryContainer),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}