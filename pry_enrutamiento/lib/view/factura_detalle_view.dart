import 'package:flutter/material.dart';
import '../model/factura_model.dart';

class FacturaDetalleView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final List<ProductoModel> productos = args['productos'];
    final Map<String, double> totales = args['totales'];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Resumen de Factura"),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  Icon(Icons.check_circle, size: 60, color: Colors.green),
                  Text("Factura Generada", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  Text("Fecha: ${DateTime.now().toString().split(' ')[0]}", style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),
            Divider(height: 40),
            Text("DETALLE DE PRODUCTOS", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.indigo)),
            Expanded(
              child: ListView.builder(
                itemCount: productos.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("${productos[index].nombre}"),
                        Text("\$${productos[index].precio.toStringAsFixed(2)}", style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  );
                },
              ),
            ),
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  _row("Subtotal", totales['subtotal']!),
                  if (totales['descuento']! > 0)
                    _row("Descuento (20%)", -totales['descuento']!, color: Colors.red),
                  Divider(),
                  _row("TOTAL A PAGAR", totales['total']!, isTotal: true),
                ],
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.popUntil(context, ModalRoute.withName('/menu')),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 15),
                ),
                child: Text("VOLVER AL MENÚ"),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _row(String label, double value, {bool isTotal = false, Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontWeight: isTotal ? FontWeight.bold : FontWeight.normal, fontSize: isTotal ? 18 : 14)),
          Text("\$${value.toStringAsFixed(2)}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: isTotal ? 20 : 14, color: color)),
        ],
      ),
    );
  }
}
