import 'package:flutter/material.dart';

class SelectorTamano extends StatelessWidget {
  final String? value;
  final ValueChanged<String?> onChanged;

  const SelectorTamano({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      initialValue: value,
      decoration: const InputDecoration(labelText: 'Seleccione el tamaño'),
      items: ['Pequeño', 'Mediano', 'Grande'].map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}
