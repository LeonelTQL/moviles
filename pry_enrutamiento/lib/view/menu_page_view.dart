import 'package:flutter/material.dart';

class MenuPageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.indigo.shade800, Colors.indigo.shade400],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.account_balance_wallet, size: 80, color: Colors.white),
            SizedBox(height: 20),
            Text(
              "GESTOR FINANCIERO",
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
            SizedBox(height: 50),
            _buildMenuButton(
              context,
              "Calculadora de Sueldo",
              Icons.calculate,
              '/',
            ),
            SizedBox(height: 20),
            _buildMenuButton(
              context,
              "Generador de Facturas",
              Icons.receipt_long,
              '/factura',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuButton(BuildContext context, String title, IconData icon, String route) {
    return SizedBox(
      width: 280,
      height: 70,
      child: ElevatedButton.icon(
        onPressed: () => Navigator.pushNamed(context, route),
        icon: Icon(icon, size: 28),
        label: Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.indigo,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          elevation: 5,
        ),
      ),
    );
  }
}
