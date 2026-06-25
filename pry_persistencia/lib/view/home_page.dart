import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import '../core/widgets/custom_app_bar.dart';
import '../core/widgets/custom_card.dart';
import '../core/widgets/custom_icon.dart';
import '../core/widgets/custom_text.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Inicio'),
      body: Center(
        child: CustomCard(child:Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomIcon(icon: Icons.home),
            SizedBox(height: 16),
            CustomText(text: 'Bienvenido a la aplicación'),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cerrar Sesión'),
            ),
          ],
        ),
      ),),
    );
  }
}
