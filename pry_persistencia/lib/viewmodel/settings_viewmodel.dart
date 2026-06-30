import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/services/notification_service.dart';

class SettingsViewModel extends ChangeNotifier {
  static const String _nameKey = 'user_name';
  static const String _emailKey = 'user_email';
  static const String _langKey = 'user_language';
  static const String _themeKey = 'is_dark_mode';

  String _name = '';
  String _email = '';
  String _language = 'Español';
  bool _isDarkMode = false;

  String get name => _name;
  String get email => _email;
  String get language => _language;
  bool get isDarkMode => _isDarkMode;

  SettingsViewModel() {
    loadSettings();
  }

  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _name = prefs.getString(_nameKey) ?? '';
    _email = prefs.getString(_emailKey) ?? '';
    _language = prefs.getString(_langKey) ?? 'Español';
    _isDarkMode = prefs.getBool(_themeKey) ?? false;
    notifyListeners();
  }

  Future<void> saveSettings({
    required String name,
    required String email,
    required String language,
    required bool isDarkMode,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_nameKey, name);
    await prefs.setString(_emailKey, email);
    await prefs.setString(_langKey, language);
    await prefs.setBool(_themeKey, isDarkMode);

    _name = name;
    _email = email;
    _language = language;
    _isDarkMode = isDarkMode;

    // Notificación automática al guardar
    await NotificationService.showNotification(
      id: 1,
      title: language == 'English' ? 'Settings Saved' : (language == 'Français' ? 'Paramètres Enregistrés' : 'Configuración Guardada'),
      body: language == 'English' 
          ? 'Your preferences have been updated.' 
          : (language == 'Français' ? 'Vos préférences ont été mises à jour.' : 'Tus preferencias se han actualizado.'),
    );

    notifyListeners();
  }

  // Traducción simple para la interfaz
  String translate(String key) {
    final Map<String, Map<String, String>> translations = {
      'Español': {
        'title': 'Mi App Personal',
        'contacts': 'Directorio de Contactos',
        'settings': 'Configuración',
        'logout': 'Cerrar Sesión',
        'welcome': 'Bienvenido a la aplicación',
      },
      'English': {
        'title': 'My Personal App',
        'contacts': 'Contact Directory',
        'settings': 'Settings',
        'logout': 'Logout',
        'welcome': 'Welcome to the application',
      },
      'Français': {
        'title': 'Mon App Personnelle',
        'contacts': 'Répertoire de Contacts',
        'settings': 'Paramètres',
        'logout': 'Se déconnecter',
        'welcome': 'Bienvenue dans l\'application',
      },
    };
    return translations[_language]?[key] ?? key;
  }
}
