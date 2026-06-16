import 'package:flutter/material.dart';
import '../models/correo_model.dart';

class CorreoViewmodel extends ChangeNotifier {
  CorreoModel _correoModel = CorreoModel(noLeidos: 22);
  int get noLeidos => _correoModel.noLeidos;

  void marcarTodosLeidos() {
    _correoModel.noLeidos = 0;
    notifyListeners();
  }

  void recibirNuevoCorreo() {
    _correoModel.noLeidos++;
    notifyListeners();
  }
}