import 'package:flutter/material.dart';

class BotonPersonalizado extends StatelessWidget {
	const BotonPersonalizado({
		super.key,
		required this.texto,
		required this.onPressed,
		this.esSecundario = false,
		this.icono,
	});

	final String texto;
	final VoidCallback onPressed;
	final bool esSecundario;
	final IconData? icono;

	@override
	Widget build(BuildContext context) {
		final Widget child = Row(
			mainAxisAlignment: MainAxisAlignment.center,
			mainAxisSize: MainAxisSize.min,
			children: [
				if (icono != null) ...[
					Icon(icono, size: 18),
					const SizedBox(width: 8),
				],
				Text(texto),
			],
		);

		if (esSecundario) {
			return OutlinedButton(
				onPressed: onPressed,
				child: child,
			);
		}

		return ElevatedButton(
			onPressed: onPressed,
			child: child,
		);
	}
}
