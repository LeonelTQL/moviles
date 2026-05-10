import 'package:flutter/material.dart';

import '../atomos/boton_personalizado.dart';
import '../atomos/campo_texto_personalizado.dart';

class FormularioLogin extends StatelessWidget {
	const FormularioLogin({
		super.key,
		required this.formKey,
		required this.usuarioController,
		required this.passwordController,
		required this.onIniciarSesion,
		required this.onLimpiar,
	});

	final GlobalKey<FormState> formKey;
	final TextEditingController usuarioController;
	final TextEditingController passwordController;
	final VoidCallback onIniciarSesion;
	final VoidCallback onLimpiar;

	@override
	Widget build(BuildContext context) {
		return Form(
			key: formKey,
			child: Column(
				crossAxisAlignment: CrossAxisAlignment.stretch,
				children: [
					CampoTextoPersonalizado(
						controller: usuarioController,
						label: 'Usuario',
						icono: Icons.person_outline,
						validator: (value) {
							if (value == null || value.trim().isEmpty) {
								return 'Ingresa el usuario';
							}
							return null;
						},
					),
					const SizedBox(height: 16),
					CampoTextoPersonalizado(
						controller: passwordController,
						label: 'Contraseña',
						icono: Icons.lock_outline,
						obscureText: true,
						validator: (value) {
							if (value == null || value.trim().isEmpty) {
								return 'Ingresa la contraseña';
							}
							return null;
						},
					),
					const SizedBox(height: 24),
					BotonPersonalizado(
						texto: 'Iniciar sesión',
						icono: Icons.login,
						onPressed: onIniciarSesion,
					),
					const SizedBox(height: 12),
					BotonPersonalizado(
						texto: 'Limpiar',
						icono: Icons.cleaning_services_outlined,
						esSecundario: true,
						onPressed: onLimpiar,
					),
				],
			),
		);
	}
}
