import '../models/promocion_model.dart';

class PromocionController {
  final List<ArticuloModel> _listaArticulos = [];

  String agregarArticulo(String nombre, String precioStr) {
    if (nombre.isEmpty || precioStr.isEmpty) {
      return "Error: Complete los datos del artículo.";
    }

    final precio = double.tryParse(precioStr);
    if (precio == null || precio <= 0) {
      return "Error: El precio debe ser un número positivo.";
    }

    _listaArticulos.add(ArticuloModel(
        nombre: nombre,
        precioOriginal: precio
    ));

    return "Éxito: Artículo añadido.";
  }

  CompraModel obtenerCompraFinal() {
    return CompraModel(articulos: _listaArticulos);
  }

  void limpiarLista() => _listaArticulos.clear();
}