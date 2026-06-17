import 'package:flutter/material.dart';
import '../views/splash_screen.dart';
import '../views/home_page.dart';
import '../views/plato_detail_page.dart';
import '../views/plato_form_page.dart';
import '../views/pedido_form_page.dart';
import '../views/pedido_summary_page.dart';
import '../views/pedidos_page.dart';
import '../../domain/entities/plato.dart';

class AppRoutes {
  static const String splash = '/';
  static const String home = '/home';
  static const String platoDetail = '/plato-detail';
  static const String platoForm = '/plato-form';
  static const String pedidoForm = '/pedido-form';
  static const String pedidoSummary = '/pedido-summary';
  static const String pedidos = '/pedidos';

  static Map<String, WidgetBuilder> get routes => {
        splash: (context) => const SplashScreen(),
        home: (context) => const HomePage(),
        pedidoForm: (context) => const PedidoFormPage(),
        pedidoSummary: (context) => const PedidoSummaryPage(),
        pedidos: (context) => const PedidosPage(),
      };

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case platoDetail:
        final plato = settings.arguments as Plato;
        return MaterialPageRoute(
          builder: (context) => PlatoDetailPage(plato: plato),
        );
      case platoForm:
        final plato = settings.arguments as Plato?;
        return MaterialPageRoute(
          builder: (context) => PlatoFormPage(plato: plato),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );
    }
  }
}
