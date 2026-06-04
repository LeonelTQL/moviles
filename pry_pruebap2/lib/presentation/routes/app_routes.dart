import 'package:flutter/material.dart';
import '../views/home_page.dart';
import '../views/character_detail_page.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> routes = {
    '/': (context) => HomePage(),
    '/detalle': (context) => const CharacterDetailPage(),
  };
}
