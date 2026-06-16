import 'package:flutter/material.dart';

import 'esquema_color.dart';

class TipografiaApp {
  static const TextTheme textTheme = TextTheme(
    headlineSmall: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w800,
      color: EsquemaColor.textoPrincipal,
    ),
    titleLarge: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w700,
      color: EsquemaColor.textoPrincipal,
    ),
    titleMedium: TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w700,
      color: EsquemaColor.textoPrincipal,
    ),
    bodyLarge: TextStyle(
      fontSize: 15,
      color: EsquemaColor.textoPrincipal,
    ),
    bodyMedium: TextStyle(
      fontSize: 13,
      color: EsquemaColor.textoSecundario,
    ),
    labelLarge: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w700,
    ),
  );
}
