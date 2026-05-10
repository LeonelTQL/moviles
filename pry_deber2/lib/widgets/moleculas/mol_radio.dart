import 'package:flutter/material.dart';
import '../atomos/atom_label.dart';

class MolRadioGroup extends StatelessWidget {
  final String title;
  final List<String> options;
  final String groupValue;
  final ValueChanged<String?> onChanged;

  const MolRadioGroup({
    required this.title,
    required this.options,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AtomLabel(text: title, isTitle: false),
        Row(
          children: options.map((option) {
            return Expanded(
              child: RadioListTile<String>(
                title: Text(option),
                value: option,
                groupValue: groupValue,
                onChanged: onChanged,
                contentPadding: EdgeInsets.zero,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}