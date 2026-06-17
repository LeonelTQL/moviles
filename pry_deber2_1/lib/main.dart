import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Themes
import 'themes/index.dart';

// Routes
import 'presentation/routes/app_routes.dart';

// Data Sources
import 'data/datasource/plato_datasource.dart';
import 'data/datasource/pedido_datasource.dart';

// Repositories
import 'data/repositories/plato_repository_implementation.dart';
import 'data/repositories/pedido_repository_implementation.dart';

// Use Cases
import 'domain/usecases/get_platos_usecase.dart';
import 'domain/usecases/create_plato_usecase.dart';
import 'domain/usecases/update_plato_usecase.dart';
import 'domain/usecases/delete_plato_usecase.dart';
import 'domain/usecases/get_pedidos_usecase.dart';
import 'domain/usecases/create_pedido_usecase.dart';
import 'domain/usecases/update_pedido_usecase.dart';
import 'domain/usecases/delete_pedido_usecase.dart';

// View Models
import 'presentation/viewmodels/plato_viewmodel.dart';
import 'presentation/viewmodels/pedido_viewmodel.dart';

void main() {
  // Initialize DataSources
  final platoDatasource = PlatoDatasource();
  final pedidoDatasource = PedidoDatasource();

  // Initialize Repositories
  final platoRepository = PlatoRepositoryImplementation(platoDatasource);
  final pedidoRepository = PedidoRepositoryImplementation(pedidoDatasource);

  // Initialize Use Cases
  final getPlatosUseCase = GetPlatosUseCase(platoRepository);
  final createPlatoUseCase = CreatePlatoUseCase(platoRepository);
  final updatePlatoUseCase = UpdatePlatoUseCase(platoRepository);
  final deletePlatoUseCase = DeletePlatoUseCase(platoRepository);

  final getPedidosUseCase = GetPedidosUseCase(pedidoRepository);
  final createPedidoUseCase = CreatePedidoUseCase(pedidoRepository);
  final updatePedidoUseCase = UpdatePedidoUseCase(pedidoRepository);
  final deletePedidoUseCase = DeletePedidoUseCase(pedidoRepository);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => PlatoViewModel(
            getPlatosUseCase: getPlatosUseCase,
            createPlatoUseCase: createPlatoUseCase,
            updatePlatoUseCase: updatePlatoUseCase,
            deletePlatoUseCase: deletePlatoUseCase,
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => PedidoViewModel(
            getPedidosUseCase: getPedidosUseCase,
            createPedidoUseCase: createPedidoUseCase,
            updatePedidoUseCase: updatePedidoUseCase,
            deletePedidoUseCase: deletePedidoUseCase,
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Restaurante App',
      theme: TemaGeneral.lightTheme,
      initialRoute: AppRoutes.splash,
      routes: AppRoutes.routes,
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}
