import 'package:flutter/material.dart';

class EsquemaColor {
  static const Color primario = Colors.deepOrange;
  static const Color secundario = Colors.orangeAccent;
  static const Color fondo = Color(0xFFF5F5F5);
  static const Color textoPrincipal = Color(0xFF212121);
  static const Color textoSecundario = Color(0xFF757575);
  
  static const ColorScheme lightScheme = ColorScheme(
    brightness: Brightness.light,
    primary: primario,
    onPrimary: Colors.white,
    secondary: secundario,
    onSecondary: Colors.black,
    error: Colors.red,
    onError: Colors.white,
    background: fondo,
    onBackground: textoPrincipal,
    surface: Colors.white,
    onSurface: textoPrincipal,
  );
}
