import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/correo_viewmodel.dart';


class GmailWidget extends StatelessWidget {
  final void Function()? onBuscarTap;
  final void Function()? onRedactarTap;
  final void Function()? onNoLeidosTap;

  const GmailWidget({
    super.key,
    this.onBuscarTap,
    this.onRedactarTap,
    this.onNoLeidosTap,
  });

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<CorreoViewmodel>(context);

    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
          boxShadow: [BoxShadow(color: Colors.black12,blurRadius: 10)],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: onBuscarTap,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(Icons.mail, color: Colors.red),
                  SizedBox(width: 10),
                  Text("Buscar en el correo", style: TextStyle(color: Colors.grey[600])),
                ],
              ),
            ),
          ),
          SizedBox(height: 16,),
          Row(
           mainAxisAlignment: MainAxisAlignment.spaceAround,
           children: [
             GestureDetector(
               onTap: onRedactarTap,
               child: Column(
                 children: [
                   Icon(Icons.edit, color: Colors.red,),
                   Text("Redactar", style: TextStyle(color: Colors.black12),),
                 ],
               ),
             ),
             GestureDetector(
               onTap: onNoLeidosTap,
               child: Column(
                 children: [
                   Icon(Icons.mark_as_unread, color: Colors.red),
                   Text("${vm.noLeidos} No leídos", style: TextStyle(color: Colors.black12)),
                   Text('${vm.noLeidos} no leidos', style: TextStyle(color: Colors.black12),)
                 ],
               ),
             ),
           ],
          )
        ],
      ),
    );
  }
}
