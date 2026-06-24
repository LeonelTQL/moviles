import 'package:flutter/material.dart';
import '../../themes/esquema_color.dart';

class PromoBanner extends StatelessWidget {
  final String title;
  final String subtitle;
  final String badge;
  final IconData icon;
  final Color background;
  final Color foreground;

  const PromoBanner({
    super.key,
    required this.title,
    required this.subtitle,
    required this.badge,
    required this.icon,
    this.background = EsquemaColor.primary,
    this.foreground = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(color: EsquemaColor.accent, borderRadius: BorderRadius.circular(20)),
                  child: Text(badge, style: const TextStyle(color: EsquemaColor.dark, fontWeight: FontWeight.w900)),
                ),
                const SizedBox(height: 14),
                Text(title, style: TextStyle(color: foreground, fontSize: 24, fontWeight: FontWeight.w900)),
                const SizedBox(height: 4),
                Text(subtitle, style: TextStyle(color: foreground.withOpacity(.88), fontWeight: FontWeight.w700)),
              ],
            ),
          ),
          Icon(icon, color: foreground, size: 86),
        ],
      ),
    );
  }
}
