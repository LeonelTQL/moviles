import 'package:flutter/material.dart';
import 'esquema_color.dart';

class TipografiaApp {
  static const TextTheme texto = TextTheme(
    displayLarge: TextStyle(
      fontSize: 28, 
      fontWeight: FontWeight.bold, 
      color: ColoresApp.textoOscuro,
      letterSpacing: -0.5,
    ),
    titleLarge: TextStyle(
      fontSize: 22, 
      fontWeight: FontWeight.w600, 
      color: ColoresApp.textoOscuro,
    ),
    titleMedium: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: ColoresApp.primario,
    ),
    bodyLarge: TextStyle(
      fontSize: 16,
      color: ColoresApp.textoOscuro,
    ),
    bodyMedium: TextStyle(
      fontSize: 14, 
      color: ColoresApp.textoGris,
    ),
    labelLarge: TextStyle(
      fontSize: 14, 
      fontWeight: FontWeight.bold,
      color: ColoresApp.primario,
    )
  );
}