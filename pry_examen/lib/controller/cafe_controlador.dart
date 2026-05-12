import '../model/pedido_cafe_modelo.dart';

class CafeControlador {

  PedidoCafeModelo procesarPedido({
    required String cliente,
    required String producto,
    required String tamano,
    required int cantidad,
  }) {

    if (cliente.isEmpty) {
      throw Exception("Ingrese el nombre del cliente");
    }

    if (producto.isEmpty) {
      throw Exception("Seleccione un producto");
    }

    if (tamano.isEmpty) {
      throw Exception("Seleccione un tamaño");
    }

    if (cantidad <= 0) {
      throw Exception("La cantidad debe ser mayor a cero");
    }

    return PedidoCafeModelo(
      cliente: cliente,
      producto: producto,
      tamano: tamano,
      cantidad: cantidad,
    );
  }
}