import 'package:flutter/material.dart';

class SelectorProducto extends StatelessWidget {
  final String? value;
  final ValueChanged<String?> onChanged;

  const SelectorProducto({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      initialValue: value,
      decoration: const InputDecoration(labelText: 'Seleccione un producto'),
      items: ['Café', 'Capuchino', 'Chocolate'].map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}
