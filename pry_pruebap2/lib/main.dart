import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data/datasource/dragonball_datasource.dart';
import 'data/repositories/character_repository_implementation.dart';
import 'domain/usescases/get_characters_usecase.dart';
import 'presentation/viewmodels/character_viewmodel.dart';
import 'presentation/routes/app_routes.dart';

void main() {
  final datasource = DragonBallDatasource();
  final repository = CharacterRepositoryImplementation(datasource);
  final usecase = GetCharactersUseCase(repository);

  runApp(MyApp(usecase: usecase, repository: repository));
}

class MyApp extends StatelessWidget {
  final GetCharactersUseCase usecase;
  final CharacterRepositoryImplementation repository;

  const MyApp({super.key, required this.usecase, required this.repository});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => CharacterViewModel(usecase, repository)),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Dragon Ball App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
          useMaterial3: true,
        ),
        initialRoute: '/',
        routes: AppRoutes.routes,
      ),
    );
  }
}
