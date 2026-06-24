import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../routes/app_routes.dart';
import '../../viewmodels/auth_viewmodel.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthViewModel>();
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Icon(Icons.delivery_dining, size: 88),
                  const SizedBox(height: 12),
                  Text('Smart Delivery', textAlign: TextAlign.center, style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 24),
                  CustomTextField(controller: _email, label: 'Correo', keyboardType: TextInputType.emailAddress, validator: (v) => v != null && v.contains('@') ? null : 'Ingrese un correo válido'),
                  const SizedBox(height: 12),
                  CustomTextField(controller: _password, label: 'Contraseña', obscureText: true, validator: (v) => v != null && v.length >= 8 ? null : 'Mínimo 8 caracteres'),
                  if (auth.error != null) Padding(padding: const EdgeInsets.only(top: 12), child: Text(auth.error!, style: const TextStyle(color: Colors.red))),
                  const SizedBox(height: 18),
                  CustomButton(
                    text: 'Ingresar',
                    loading: auth.loading,
                    onPressed: () async {
                      if (!_formKey.currentState!.validate()) return;
                      final ok = await auth.login(_email.text, _password.text);
                      if (!mounted || !ok) return;
                      final user = auth.user!;
                      if (user.isAdmin) Navigator.pushReplacementNamed(context, AppRoutes.adminDashboard);
                      else if (user.isDelivery) Navigator.pushReplacementNamed(context, AppRoutes.deliveryOrders);
                      else Navigator.pushReplacementNamed(context, AppRoutes.home);
                    },
                  ),
                  TextButton(onPressed: () => Navigator.pushNamed(context, AppRoutes.register), child: const Text('Crear cuenta')),
                  const SizedBox(height: 12),
                  const Text('Demo: cliente@smartdelivery.com / repartidor@smartdelivery.com / admin@smartdelivery.com Contraseña: 12345678', textAlign: TextAlign.center),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
