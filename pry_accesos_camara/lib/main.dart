import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/foto_provider.dart';
import 'views/home_view.dart';
import 'views/foto_view.dart';
import 'views/perfil_view.dart';

void main(){
  runApp(
    MultiProvider(
        providers:[
          ChangeNotifierProvider(create: (_)=> FotoProvider()),
        ],
      child: MyApp(),

    )
  );
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>{
  int index=0;
  final screen=[
    HomeView(),
    FotoView(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: screen[index],
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: index,
          selectedItemColor: Colors.grey,
          unselectedItemColor: Colors.blue,
          onTap: (i) => setState(() => index = i),
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.image),label:"Fotos"),
          ],
        ),
      ),
    );
  }
}
