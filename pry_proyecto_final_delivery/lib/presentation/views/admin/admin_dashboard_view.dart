import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../routes/app_routes.dart';
import '../../viewmodels/auth_viewmodel.dart';

class AdminDashboardView extends StatelessWidget {
  const AdminDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Administrador'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await context.read<AuthViewModel>().logout();
              if (context.mounted) Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login, (_) => false);
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          children: [
            _AdminCard(icon: Icons.receipt_long, title: 'Pedidos', onTap: () => Navigator.pushNamed(context, AppRoutes.adminOrders)),
            _AdminCard(icon: Icons.add_box, title: 'Nuevo producto', onTap: () => Navigator.pushNamed(context, AppRoutes.adminProductForm)),
            _AdminCard(icon: Icons.fastfood, title: 'Catálogo', onTap: () => Navigator.pushNamed(context, AppRoutes.home)),
            _AdminCard(icon: Icons.analytics, title: 'Reportes', onTap: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Módulo pendiente')))),
          ],
        ),
      ),
    );
  }
}

class _AdminCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  const _AdminCard({required this.icon, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(icon, size: 48), const SizedBox(height: 12), Text(title, textAlign: TextAlign.center)]),
      ),
    );
  }
}
