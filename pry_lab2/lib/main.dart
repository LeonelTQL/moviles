import 'package:flutter/material.dart';
import 'views/splash_view.dart';
import 'views/registro_venta_view.dart';
import 'views/resultado_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sistema de Ventas',
      initialRoute: '/',
      routes: {
        '/': (context) => SplashView(),
        '/registro': (context) => RegistroVentaView(),
        '/resultado': (context) => ResultadoView(),
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
    );
  }
}