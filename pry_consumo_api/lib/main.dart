import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data/datasource/pokeapi_datasource.dart';
import 'data/repositories/pokemon_repository_implementation.dart';
import 'domain/entities/pokemon.dart';
import 'domain/usescases/get_pokemons_usecase.dart';
import 'presentation/viewmodels/pokemon_viewmodel.dart';
import 'presentation/routes/app_routes.dart';

void main() {

  final datasource = PokeApiDatasource();
  final repository = PokemonRepositoryImplementation(datasource);
  final usecase = GetPokemonsUseCase(repository);

  runApp(MyApp(usecase: usecase));
}

class MyApp extends StatelessWidget {
  final GetPokemonsUseCase usecase;
  const MyApp({super.key, required this.usecase});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PokemonViewModel(usecase)),     
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Pokemon App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurpleAccent),
          useMaterial3: true,
        ),
        initialRoute: '/',
        routes: AppRoutes.routes,
      ),
    );
  }
}
