import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../routes/app_routes.dart';
import '../../viewmodels/auth_viewmodel.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _phone = TextEditingController();
  final _password = TextEditingController();
  String _role = 'cliente';

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthViewModel>();
    return Scaffold(
      appBar: AppBar(title: const Text('Registro')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomTextField(controller: _name, label: 'Nombre completo', validator: (v) => v != null && v.length >= 3 ? null : 'Mínimo 3 caracteres'),
              const SizedBox(height: 12),
              CustomTextField(controller: _email, label: 'Correo', keyboardType: TextInputType.emailAddress, validator: (v) => v != null && v.contains('@') ? null : 'Correo inválido'),
              const SizedBox(height: 12),
              CustomTextField(controller: _phone, label: 'Teléfono', keyboardType: TextInputType.phone, validator: (v) => v != null && v.length >= 7 ? null : 'Teléfono inválido'),
              const SizedBox(height: 12),
              CustomTextField(controller: _password, label: 'Contraseña', obscureText: true, validator: (v) => v != null && v.length >= 8 ? null : 'Mínimo 8 caracteres'),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: _role,
                decoration: const InputDecoration(labelText: 'Rol'),
                items: const [
                  DropdownMenuItem(value: 'cliente', child: Text('Cliente')),
                  DropdownMenuItem(value: 'repartidor', child: Text('Repartidor')),
                ],
                onChanged: (v) => setState(() => _role = v ?? 'cliente'),
              ),
              if (auth.error != null) Padding(padding: const EdgeInsets.only(top: 12), child: Text(auth.error!, style: const TextStyle(color: Colors.red))),
              const SizedBox(height: 18),
              CustomButton(
                text: 'Registrarme',
                loading: auth.loading,
                onPressed: () async {
                  if (!_formKey.currentState!.validate()) return;
                  final ok = await auth.register(name: _name.text, email: _email.text, password: _password.text, phone: _phone.text, role: _role);
                  if (!mounted || !ok) return;
                  Navigator.pushReplacementNamed(context, _role == 'repartidor' ? AppRoutes.deliveryOrders : AppRoutes.home);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
