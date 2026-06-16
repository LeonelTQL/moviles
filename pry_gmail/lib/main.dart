import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data/datasource/correo_local_datasource.dart';
import 'data/datasource/gmail_api_datasource.dart';
import 'data/datasource/gmail_config.dart';
import 'data/repositories/correo_repository_impl.dart';
import 'presentation/routes/app_routes.dart';
import 'presentation/viewmodels/correo_viewmodel.dart';
import 'themes/index.dart';

void main() {
  final repository = CorreoRepositoryImpl(
    localDatasource: CorreoLocalDatasource(),
    gmailApiDatasource: GmailApiDatasource(
      serverClientId: GmailConfig.serverClientId,
    ),
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CorreoViewModel(repository: repository)..cargarCorreos(),
        ),
      ],
      child: const GmailPrototypeApp(),
    ),
  );
}

class GmailPrototypeApp extends StatelessWidget {
  const GmailPrototypeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Widget tipo Gmail',
      theme: ThemeGeneral.lightTheme,
      initialRoute: AppRoutes.home,
      routes: AppRoutes.routes,
    );
  }
}
