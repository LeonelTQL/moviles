import 'package:flutter/material.dart';

class TextoTituloApp extends StatelessWidget {
  final String texto;
  final TextAlign textAlign;

  const TextoTituloApp(
    this.texto, {
    super.key,
    this.textAlign = TextAlign.start,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      texto,
      textAlign: textAlign,
      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
    );
  }
}
