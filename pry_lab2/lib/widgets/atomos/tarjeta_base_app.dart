import 'package:flutter/material.dart';

class TarjetaBaseApp extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;

  const TarjetaBaseApp({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: padding,
        child: child,
      ),
    );
  }
}
