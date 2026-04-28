import 'package:flutter/material.dart';
import 'pantallas/calcu.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override

  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Terreno",
      theme: ThemeData(primaryColor: Colors.blue),
      home: Calcu(),
    );
  }
}






// import 'pantallas/calcular_area.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget{
//   @override
//
//   Widget build(BuildContext context){
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: "Terreno",
//       theme: ThemeData(primaryColor: Colors.blue),
//       home: TerrenoPagina(),
//     );
//   }
// }
//
// class MyApp extends StatelessWidget{
//
//
//
//   @override
//   Widget build(BuildContext context){
//     return MaterialApp(
//       debugShowCheckedModeBanner:false,
//
//       home:Scaffold(
//         appBar: AppBar(
//           title: Text("Mi primera app"),
//           backgroundColor: Colors.blue,
//         ),
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text("Hola jiji", style: TextStyle(fontSize:24, fontWeight: FontWeight.bold),
//               ),
//
//               SizedBox(height: 20,),
//
//               Text("Hola ahhhhh", style: TextStyle(fontSize:24, fontWeight: FontWeight.bold),
//               ),
//               ElevatedButton(onPressed: ()=> print("que rico"), child: Text("Tocame papi..."))
//             ],
//           ),
//         ),
//       )
//
//     );
//   }
// }