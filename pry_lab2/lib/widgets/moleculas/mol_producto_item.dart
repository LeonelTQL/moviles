import 'package:flutter/material.dart';
import '../atomos/atom_label.dart';

class MolProductoItem extends StatelessWidget {
  final String nombre;
  final int cantidad;
  final double total;
  final VoidCallback onEliminar;

  const MolProductoItem({
    super.key,
    required this.nombre,
    required this.cantidad,
    required this.total,
    required this.onEliminar,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        title: AtomLabel(text: nombre, isTitle: false),
        subtitle: Text("Cant: $cantidad | Total: \$${total.toStringAsFixed(2)}"),
        trailing: IconButton(
          icon: Icon(Icons.delete, color: Colors.red),
          onPressed: onEliminar,
        ),
      ),
    );
  }
}