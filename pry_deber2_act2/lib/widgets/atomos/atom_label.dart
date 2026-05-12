import 'package:flutter/material.dart';

class AtomLabel extends StatelessWidget {
  final String text;
  final bool isTitle;

  const AtomLabel({required this.text, this.isTitle = false});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: isTitle ? 20 : 16,
        fontWeight: isTitle ? FontWeight.bold : FontWeight.normal,
        color: isTitle ? Theme.of(context).colorScheme.primary : Colors.white70,
      ),
    );
  }
}