import 'package:flutter/material.dart';

class TextoEtiqueta extends StatelessWidget {
  final String etiqueta;
  final String valor;

  const TextoEtiqueta({
    super.key,
    required this.etiqueta,
    required this.valor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            etiqueta,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(valor),
        ],
      ),
    );
  }
}
