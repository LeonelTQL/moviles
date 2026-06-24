import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../themes/esquema_color.dart';
import '../../routes/app_routes.dart';
import '../../viewmodels/auth_viewmodel.dart';
import '../../widgets/app_bottom_nav.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthViewModel>().user;
    return Scaffold(
      bottomNavigationBar: const AppBottomNav(currentIndex: 4),
      body: SafeArea(
        child: user == null
            ? const Center(child: Text('Sin sesión'))
            : ListView(
                padding: const EdgeInsets.fromLTRB(24, 26, 24, 26),
                children: [
                  Row(
                    children: [
                      Expanded(child: Text('¡Hola, ${user.name}!', style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 24, color: EsquemaColor.dark))),
                      const CircleAvatar(radius: 26, backgroundColor: EsquemaColor.chip, child: Icon(Icons.person, color: EsquemaColor.dark)),
                    ],
                  ),
                  const SizedBox(height: 32),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(color: EsquemaColor.purple, borderRadius: BorderRadius.circular(24)),
                    child: const Row(
                      children: [
                        CircleAvatar(backgroundColor: Colors.white, child: Text('plus', style: TextStyle(color: EsquemaColor.purple, fontWeight: FontWeight.w900))),
                        SizedBox(width: 16),
                        Expanded(child: Text('¡Prueba Plus!\nEnvíos gratis y promos especiales.', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 16))),
                        Icon(Icons.chevron_right, color: Colors.white, size: 32),
                      ],
                    ),
                  ),
                  const SizedBox(height: 28),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      _QuickAction(icon: Icons.person_outline, label: 'Información\npersonal'),
                      _QuickAction(icon: Icons.confirmation_num_outlined, label: 'Cupones'),
                      _QuickAction(icon: Icons.star_outline, label: 'Plus'),
                      _QuickAction(icon: Icons.support_agent_outlined, label: 'Ayuda'),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(color: EsquemaColor.chip, borderRadius: BorderRadius.circular(22)),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Completa tu perfil', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: EsquemaColor.dark)),
                        SizedBox(height: 4),
                        Text('0 de 3', style: TextStyle(color: EsquemaColor.muted)),
                        SizedBox(height: 16),
                        LinearProgressIndicator(value: .1, minHeight: 6, borderRadius: BorderRadius.all(Radius.circular(12))),
                        SizedBox(height: 8),
                        Text('Selecciona tu fecha de nacimiento y género.'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 28),
                  const Text('Perfil', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: EsquemaColor.dark)),
                  _ProfileTile(icon: Icons.location_on_outlined, title: 'Direcciones', subtitle: user.email),
                  const _ProfileTile(icon: Icons.favorite_border, title: 'Favoritos'),
                  const SizedBox(height: 18),
                  const Text('Actividad', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: EsquemaColor.dark)),
                  const _ProfileTile(icon: Icons.account_balance_wallet_outlined, title: 'Medios de pago'),
                  _ProfileTile(icon: Icons.badge_outlined, title: 'Rol', subtitle: user.role),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () async {
                      await context.read<AuthViewModel>().logout();
                      if (context.mounted) Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login, (_) => false);
                    },
                    icon: const Icon(Icons.logout),
                    label: const Text('Cerrar sesión'),
                  ),
                ],
              ),
      ),
    );
  }
}

class _QuickAction extends StatelessWidget {
  final IconData icon;
  final String label;
  const _QuickAction({required this.icon, required this.label});
  @override
  Widget build(BuildContext context) {
    return Column(children: [Container(width: 70, height: 70, decoration: BoxDecoration(color: EsquemaColor.chip, borderRadius: BorderRadius.circular(20)), child: Icon(icon, color: EsquemaColor.dark, size: 30)), const SizedBox(height: 8), Text(label, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.w700))]);
  }
}

class _ProfileTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  const _ProfileTile({required this.icon, required this.title, this.subtitle});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 8),
      leading: Icon(icon, size: 32, color: EsquemaColor.dark),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 17)),
      subtitle: subtitle == null ? null : Text(subtitle!),
      trailing: const Icon(Icons.chevron_right, size: 34, color: EsquemaColor.dark),
    );
  }
}
