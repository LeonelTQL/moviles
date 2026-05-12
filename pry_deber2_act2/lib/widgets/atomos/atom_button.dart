import 'package:flutter/material.dart';

class AtomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool isPrimary;

  const AtomButton({
    required this.label,
    required this.onPressed,
    this.isPrimary = true
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: isPrimary ? Theme.of(context).colorScheme.primary : Colors.grey[800],
        foregroundColor: isPrimary ? Colors.black : Colors.white,
      ),
      onPressed: onPressed,
      child: Text(label),
    );
  }
}