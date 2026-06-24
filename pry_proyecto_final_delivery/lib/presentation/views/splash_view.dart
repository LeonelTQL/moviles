import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../routes/app_routes.dart';
import '../viewmodels/auth_viewmodel.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      final auth = context.read<AuthViewModel>();
      await auth.loadSession();
      if (!mounted) return;
      final user = auth.user;
      if (user == null) {
        Navigator.pushReplacementNamed(context, AppRoutes.login);
      } else if (user.isAdmin) {
        Navigator.pushReplacementNamed(context, AppRoutes.adminDashboard);
      } else if (user.isDelivery) {
        Navigator.pushReplacementNamed(context, AppRoutes.deliveryOrders);
      } else {
        Navigator.pushReplacementNamed(context, AppRoutes.home);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
