import 'package:flutter/material.dart';

class TextoSubtituloApp extends StatelessWidget {
  final String texto;
  final TextAlign textAlign;

  const TextoSubtituloApp(
    this.texto, {
    super.key,
    this.textAlign = TextAlign.start,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      texto,
      textAlign: textAlign,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
    );
  }
}
