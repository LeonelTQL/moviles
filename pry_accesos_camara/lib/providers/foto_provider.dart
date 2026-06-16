import 'package:provider/provider.dart';
import '../models/foto.dart';
import 'package:flutter/material.dart';

class FotoProvider extends ChangeNotifier{
  final List<Foto> _fotos=[];

  List<Foto> get fotos => _fotos;


  void agregarFoto(Foto foto) {
    _fotos.add(foto);
    notifyListeners();
  }

  void eliminarFoto(Foto foto) {
    _fotos.remove(foto);
    notifyListeners();
  }

  void limpiarFotos() {
    _fotos.clear();
    notifyListeners();
  }
}