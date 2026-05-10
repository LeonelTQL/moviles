import 'package:flutter/material.dart';

import '../../controller/login_controller.dart';
import '../../model/usuario_model.dart';
import '../../themes/esquema_color.dart';
import '../../themes/tema_fondos.dart';
import '../moleculas/formulario_login.dart';
import 'vista_bienvenida.dart';

class VistaLogin extends StatefulWidget {
	const VistaLogin({super.key});

	@override
	State<VistaLogin> createState() => _VistaLoginState();
}

class _VistaLoginState extends State<VistaLogin> {
	final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
	final TextEditingController _usuarioController = TextEditingController();
	final TextEditingController _passwordController = TextEditingController();
	final LoginController _loginController = LoginController();

	@override
	void dispose() {
		_usuarioController.dispose();
		_passwordController.dispose();
		super.dispose();
	}

	void _limpiar() {
		_usuarioController.clear();
		_passwordController.clear();
	}

	void _iniciarSesion() {
		if (!_formKey.currentState!.validate()) {
			return;
		}

		final UsuarioModel usuario = UsuarioModel(
			nombreUsuario: _usuarioController.text.trim(),
			password: _passwordController.text.trim(),
		);

		final String? mensaje = _loginController.validar(usuario);
		if (mensaje != null) {
			ScaffoldMessenger.of(context).showSnackBar(
				SnackBar(content: Text(mensaje)),
			);
			return;
		}

		if (_loginController.autenticar(usuario)) {
			Navigator.pushReplacement(
				context,
				MaterialPageRoute(
					builder: (context) => VistaBienvenida(nombreUsuario: usuario.nombreUsuario),
				),
			);
			return;
		}

		ScaffoldMessenger.of(context).showSnackBar(
			const SnackBar(
				content: Text('Usuario o contraseña incorrectos'),
				backgroundColor: ColoresApp.error,
			),
		);
	}

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			body: Container(
				decoration: FondoApp.degradadoPrinicpal,
				child: SafeArea(
					child: Center(
						child: SingleChildScrollView(
							padding: const EdgeInsets.all(24),
							child: Card(
								elevation: 10,
								shape: RoundedRectangleBorder(
									borderRadius: BorderRadius.circular(24),
								),
								child: Padding(
									padding: const EdgeInsets.all(24),
									child: Column(
										mainAxisSize: MainAxisSize.min,
										children: [
											const Icon(
												Icons.account_circle_outlined,
												size: 72,
												color: ColoresApp.primario,
											),
											const SizedBox(height: 16),
											Text(
												'Bienvenido',
												textAlign: TextAlign.center,
												style: Theme.of(context).textTheme.headlineMedium?.copyWith(
															color: ColoresApp.textoOscuro,
															fontWeight: FontWeight.bold,
														),
											),
											const SizedBox(height: 8),
											Text(
												'Ingresa tus datos para continuar',
												textAlign: TextAlign.center,
												style: Theme.of(context).textTheme.bodyMedium,
											),
											const SizedBox(height: 28),
											FormularioLogin(
												formKey: _formKey,
												usuarioController: _usuarioController,
												passwordController: _passwordController,
												onIniciarSesion: _iniciarSesion,
												onLimpiar: _limpiar,
											),
											const SizedBox(height: 16),
											Text(
												'Prueba: usuario leo y contraseña 1234',
												textAlign: TextAlign.center,
												style: Theme.of(context).textTheme.labelLarge?.copyWith(
															color: Colors.grey.shade600,
														),
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
