import 'package:flutter/material.dart';

import 'esquema_color.dart';

class TemaFormulario {
  static InputDecorationTheme get inputDecorationTheme {
    return InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFFF9FAFB),
      hintStyle: const TextStyle(color: EsquemaColor.textoSecundario),
      prefixIconColor: EsquemaColor.textoSecundario,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: EsquemaColor.borde),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: EsquemaColor.borde),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: EsquemaColor.gmailRojo, width: 1.4),
      ),
    );
  }
}
