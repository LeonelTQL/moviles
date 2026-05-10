import 'package:flutter/material.dart';

import '../../themes/esquema_color.dart';
import '../../themes/tema_fondos.dart';

class VistaBienvenida extends StatelessWidget {
	const VistaBienvenida({super.key, this.nombreUsuario = 'Usuario'});

	final String nombreUsuario;

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			body: Container(
				decoration: FondoApp.degradadoPrinicpal,
				child: SafeArea(
					child: Center(
						child: Padding(
							padding: const EdgeInsets.all(24),
							child: Card(
								elevation: 12,
								shape: RoundedRectangleBorder(
									borderRadius: BorderRadius.circular(24),
								),
								child: Padding(
									padding: const EdgeInsets.all(28),
									child: Column(
										mainAxisSize: MainAxisSize.min,
										children: [
											const Icon(
												Icons.celebration_outlined,
												size: 74,
												color: ColoresApp.primario,
											),
											const SizedBox(height: 16),
											Text(
												'Bienvenido, $nombreUsuario',
												textAlign: TextAlign.center,
												style: Theme.of(context).textTheme.headlineMedium?.copyWith(
															color: ColoresApp.textoOscuro,
															fontWeight: FontWeight.bold,
														),
											),
											const SizedBox(height: 12),
											Text(
												'La autenticación fue exitosa y ya puedes continuar con tu flujo.',
												textAlign: TextAlign.center,
												style: Theme.of(context).textTheme.bodyMedium,
											),
											const SizedBox(height: 24),
											ElevatedButton(
												onPressed: () {
													Navigator.pushReplacementNamed(context, '/');
												},
												child: const Text('Cerrar sesión'),
											),
										],
									),
								),
							),
						),
					),
				),
			),
		);
	}
}
