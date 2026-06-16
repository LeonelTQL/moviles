import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../viewmodels/correo_viewmodel.dart';
import 'gmail_widget.dart';


class HomePage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<CorreoViewmodel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Gmail Widget Demo'),
      ),
      body: Center(
        child: GmailWidget(
          onBuscarTap: (){
            showDialog(context: context,
                builder: (_) => AlertDialog(
                  title: Text('Buscar'),
                  content: Text('Aqui se busca'),
                )
            );
          },
          onRedactarTap: (){
            vm.recibirNuevoCorreo();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Nuevo correo recibido'))
            );
          },
          onNoLeidosTap:(){
            vm.marcarTodosLeidos();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Correos marcados como leídos'))
            );
          },
        ),
      ),
    );
  }
}