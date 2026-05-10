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
        fontSize: isTitle ? 18 : 14,
        fontWeight: isTitle ? FontWeight.bold : FontWeight.w500,
        color: isTitle ? Theme.of(context).colorScheme.primary : Colors.black87,
      ),
    );
  }
}