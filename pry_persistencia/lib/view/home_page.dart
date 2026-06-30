import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/theme/app_colors.dart';
import '../viewmodel/settings_viewmodel.dart';
import 'settings_page.dart';
import 'contact_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<SettingsViewModel>();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            title: Text(viewModel.translate('title')),
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.primary, AppColors.primaryDark],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: const Opacity(
                  opacity: 0.1,
                  child: Icon(Icons.apps, size: 200, color: Colors.white),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(24),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _buildMenuCard(
                  context,
                  title: viewModel.translate('contacts'),
                  subtitle: viewModel.language == 'English' 
                      ? 'Manage your contacts locally' 
                      : (viewModel.language == 'Français' ? 'Gérez vos contacts localement' : 'Gestiona tus contactos localmente'),
                  icon: Icons.contact_phone_rounded,
                  color: AppColors.primary,
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ContactPage())),
                ),
                const SizedBox(height: 16),
                _buildMenuCard(
                  context,
                  title: viewModel.translate('settings'),
                  subtitle: viewModel.language == 'English' 
                      ? 'Personalize your experience' 
                      : (viewModel.language == 'Français' ? 'Personnalisez votre expérience' : 'Personaliza tu experiencia'),
                  icon: Icons.settings_rounded,
                  color: AppColors.secondary,
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsPage())),
                ),
                const SizedBox(height: 40),
                TextButton.icon(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.logout, color: AppColors.error),
                  label: Text(
                    viewModel.translate('logout'),
                    style: const TextStyle(color: AppColors.error, fontWeight: FontWeight.bold),
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Theme.of(context).cardTheme.color,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Icon(icon, color: color, size: 30),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(color: AppColors.textLight, fontSize: 14),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
