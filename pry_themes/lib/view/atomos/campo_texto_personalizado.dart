import 'package:flutter/material.dart';

class CampoTextoPersonalizado extends StatelessWidget {
	const CampoTextoPersonalizado({
		super.key,
		required this.controller,
		required this.label,
		required this.icono,
		this.obscureText = false,
		this.validator,
	});

	final TextEditingController controller;
	final String label;
	final IconData icono;
	final bool obscureText;
	final String? Function(String?)? validator;

	@override
	Widget build(BuildContext context) {
		return TextFormField(
			controller: controller,
			obscureText: obscureText,
			validator: validator,
			decoration: InputDecoration(
				labelText: label,
				prefixIcon: Icon(icono),
			),
		);
	}
}
