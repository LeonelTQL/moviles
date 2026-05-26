import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'domain/usecases/calcular_aumento_usecase.dart';
import 'presentation/viewmodels/operario_viewmodel.dart';
import 'presentation/routes/app_routes.dart';

void main(){
  runApp(
    ChangeNotifierProvider(
      create: (_) => OperarioViewmodel(CalcularAumentoUsecase()),
      child: MyApp(),
    )
  );
}


class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Calcular sueldo",
      debugShowCheckedModeBanner: false,

      initialRoute: AppRoutes.home,
      routes: AppRoutes.routes,
    );
  }
}