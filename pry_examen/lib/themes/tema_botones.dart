import 'package:flutter/material.dart';
import 'esquema_color.dart';


class TemaBotones {
  static final botonPrincipal = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: ColoresApp.primario,
      foregroundColor: ColoresApp.textoClaro,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      textStyle: TextStyle(fontWeight: FontWeight.bold)
    ),
  );

  static final botonSecundario = OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
      foregroundColor: ColoresApp.secundario,
      side: BorderSide(color: ColoresApp.primario),
      shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(10)),
    )
  );
}