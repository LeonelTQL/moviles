import 'package:flutter/material.dart';
import 'themes/index.dart';
import 'view/paginas/vista_bienvenida.dart';
import 'view/paginas/vista_login.dart';
import 'themes/teme_general.dart';

void main() {
  runApp(const AplicacionBase());
}

class AplicacionBase extends StatelessWidget {
  const AplicacionBase({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login MVC + Atomic + Temas',
      theme: TemeGeneral.claro,
      initialRoute: '/',
      routes: {
        '/': (context) => const VistaLogin(),
        '/bienvenida': (context) => const VistaBienvenida(),
      },
    );
  }
}