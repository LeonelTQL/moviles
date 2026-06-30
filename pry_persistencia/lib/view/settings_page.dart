import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/theme/app_colors.dart';
import '../viewmodel/settings_viewmodel.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  String _selectedLanguage = 'Español';
  bool _isDarkMode = false;

  @override
  void initState() {
    super.initState();
    final viewModel = context.read<SettingsViewModel>();
    _nameController = TextEditingController(text: viewModel.name);
    _emailController = TextEditingController(text: viewModel.email);
    _selectedLanguage = viewModel.language;
    _isDarkMode = viewModel.isDarkMode;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.watch<SettingsViewModel>().translate('settings')),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Perfil'),
            _buildSectionCard([
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nombre',
                  prefixIcon: Icon(Icons.person_outline),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Correo Electrónico',
                  prefixIcon: Icon(Icons.email_outlined),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
            ]),
            const SizedBox(height: 24),
            _buildSectionTitle('Preferencias'),
            _buildSectionCard([
              _buildDropdownTile(
                label: 'Idioma',
                icon: Icons.language,
                value: _selectedLanguage,
                items: ['Español', 'English', 'Français'],
                onChanged: (v) => setState(() => _selectedLanguage = v!),
              ),
              const Divider(height: 32),
              _buildSwitchTile(
                label: 'Tema Oscuro',
                icon: Icons.dark_mode_outlined,
                value: _isDarkMode,
                onChanged: (v) => setState(() => _isDarkMode = v),
              ),
            ]),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                context.read<SettingsViewModel>().saveSettings(
                  name: _nameController.text,
                  email: _emailController.text,
                  language: _selectedLanguage,
                  isDarkMode: _isDarkMode,
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(_selectedLanguage == 'English' ? 'Settings Saved' : (_selectedLanguage == 'Français' ? 'Paramètres Enregistrés' : 'Configuración Guardada')),
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    backgroundColor: AppColors.secondary,
                  ),
                );
              },
              child: const Text('Guardar Cambios'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 12),
      child: Text(
        title.toUpperCase(),
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.bold,
          color: AppColors.textLight,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildSectionCard(List<Widget> children) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(children: children),
    );
  }

  Widget _buildDropdownTile({
    required String label,
    required IconData icon,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Row(
      children: [
        Icon(icon, color: AppColors.primary, size: 22),
        const SizedBox(width: 12),
        Expanded(child: Text(label, style: const TextStyle(fontSize: 16))),
        DropdownButton<String>(
          value: value,
          underline: const SizedBox(),
          items: items.map((String v) => DropdownMenuItem(value: v, child: Text(v))).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _buildSwitchTile({
    required String label,
    required IconData icon,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return SwitchListTile(
      contentPadding: EdgeInsets.zero,
      title: Row(
        children: [
          Icon(icon, color: AppColors.primary, size: 22),
          const SizedBox(width: 12),
          Text(label, style: const TextStyle(fontSize: 16)),
        ],
      ),
      value: value,
      activeColor: AppColors.primary,
      onChanged: onChanged,
    );
  }
}
