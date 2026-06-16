import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data/datasource/policy_remote_datasource.dart';
import 'data/repositories/policy_repository.dart';
import 'domain/usecases/create_policy_usecase.dart';
import 'domain/usecases/delete_policy_usecase.dart';
import 'domain/usecases/get_policies_usecase.dart';
import 'domain/usecases/update_policy_usecase.dart';
import 'presentation/routes/app_routes.dart';
import 'presentation/viewmodels/policy_viewmodel.dart';
import 'presentation/views/main_navigation_view.dart';

void main() {
  runApp(const PolicyApp());
}

class PolicyApp extends StatelessWidget {
  const PolicyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF1E3A8A);
    const secondaryColor = Color(0xFF0F766E);

    return ChangeNotifierProvider(
      create: (_) {
        final dataSource = PolicyRemoteDataSource();
        final repository = PolicyRepository(remoteDataSource: dataSource);

        return PolicyViewModel(
          getPoliciesUseCase: GetPoliciesUseCase(repository),
          createPolicyUseCase: CreatePolicyUseCase(repository),
          updatePolicyUseCase: UpdatePolicyUseCase(repository),
          deletePolicyUseCase: DeletePolicyUseCase(repository),
        );
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Pólizas de Seguro',
        initialRoute: AppRoutes.home,
        routes: {
          AppRoutes.home: (_) => const MainNavigationView(),
        },
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: primaryColor,
            primary: primaryColor,
            secondary: secondaryColor,
            surface: Colors.white,
            background: const Color(0xFFF4F7FB),
          ),
          scaffoldBackgroundColor: const Color(0xFFF4F7FB),
          appBarTheme: const AppBarTheme(
            centerTitle: true,
            elevation: 0,
            backgroundColor: primaryColor,
            foregroundColor: Colors.white,
            titleTextStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
          cardTheme: CardThemeData(
            elevation: 0,
            color: Colors.white,
            surfaceTintColor: Colors.white,
            margin: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(22),
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: primaryColor, width: 1.6),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
          filledButtonTheme: FilledButtonThemeData(
            style: FilledButton.styleFrom(
              minimumSize: const Size.fromHeight(52),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              textStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
            ),
          ),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: Colors.white,
            selectedItemColor: primaryColor,
            unselectedItemColor: Color(0xFF64748B),
            type: BottomNavigationBarType.fixed,
            elevation: 14,
            selectedLabelStyle: TextStyle(fontWeight: FontWeight.w800),
          ),
        ),
      ),
    );
  }
}
