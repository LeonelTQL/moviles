import 'package:flutter/material.dart';
import 'esquema_color.dart';
import 'tema_botones.dart';
import 'tema_formulario.dart';
import 'temas_appbar.dart';
import 'tipografia.dart';

class TemeGeneral {
  static ThemeData claro = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: ColoresApp.primario,
      primary: ColoresApp.primario,
      secondary: ColoresApp.secundario,
      surface: ColoresApp.fondo,
      onPrimary: ColoresApp.textoClaro,
      onSecondary: Colors.white,
      error: ColoresApp.error,
    ),
    textTheme: TipografiaApp.texto,
    appBarTheme: TemaAppBar.estilo,
    elevatedButtonTheme: TemaBotones.botonPrincipal,
    outlinedButtonTheme: TemaBotones.botonSecundario,
    inputDecorationTheme: TemaFormularios.camposTexto,
    scaffoldBackgroundColor: ColoresApp.fondo,
  );
}