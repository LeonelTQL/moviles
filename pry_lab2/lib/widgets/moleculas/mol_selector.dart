import 'package:flutter/material.dart';

class MolSelector extends StatelessWidget {
  final String etiqueta;
  final String valorActual;
  final List<String> opciones;
  final ValueChanged<String?> alCambiar;

  const MolSelector({
    super.key,
    required this.etiqueta,
    required this.valorActual,
    required this.opciones,
    required this.alCambiar,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: DropdownButtonFormField<String>(
        initialValue: valorActual,
        decoration: InputDecoration(
          labelText: etiqueta,
        ),
        items: opciones.map((opcion) => DropdownMenuItem(value: opcion, child: Text(opcion))).toList(),
        onChanged: alCambiar,
      ),
    );
  }
}
