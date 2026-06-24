import 'package:flutter/material.dart';
import '../routes/app_routes.dart';
import '../../themes/esquema_color.dart';

class AppBottomNav extends StatelessWidget {
  final int currentIndex;
  const AppBottomNav({super.key, required this.currentIndex});

  void _go(BuildContext context, int index) {
    if (index == currentIndex) return;
    final route = switch (index) {
      0 => AppRoutes.home,
      1 => AppRoutes.superMarket,
      2 => AppRoutes.promotions,
      3 => AppRoutes.history,
      _ => AppRoutes.profile,
    };
    Navigator.pushReplacementNamed(context, route);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Color(0x14000000), blurRadius: 18, offset: Offset(0, -4))],
      ),
      child: SafeArea(
        top: false,
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) => _go(context, index),
          selectedFontSize: 12,
          unselectedFontSize: 12,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home_outlined), activeIcon: Icon(Icons.home_rounded), label: 'Inicio'),
            BottomNavigationBarItem(icon: Icon(Icons.shopping_basket_outlined), activeIcon: Icon(Icons.shopping_basket), label: 'Súper'),
            BottomNavigationBarItem(icon: Icon(Icons.percent_outlined), activeIcon: Icon(Icons.percent), label: 'Promos'),
            BottomNavigationBarItem(icon: Icon(Icons.receipt_long_outlined), activeIcon: Icon(Icons.receipt_long), label: 'Pedidos'),
            BottomNavigationBarItem(icon: Icon(Icons.person_outline), activeIcon: Icon(Icons.person), label: 'Mi perfil'),
          ],
          selectedItemColor: EsquemaColor.dark,
          unselectedItemColor: EsquemaColor.dark,
        ),
      ),
    );
  }
}
