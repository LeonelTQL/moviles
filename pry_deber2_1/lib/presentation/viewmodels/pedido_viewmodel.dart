import 'package:flutter/material.dart';
import '../../domain/entities/pedido.dart';
import '../../domain/entities/pedido_detalle.dart';
import '../../domain/entities/plato.dart';
import '../../domain/usecases/get_pedidos_usecase.dart';
import '../../domain/usecases/create_pedido_usecase.dart';
import '../../domain/usecases/update_pedido_usecase.dart';
import '../../domain/usecases/delete_pedido_usecase.dart';

class PedidoViewModel extends ChangeNotifier {
  final GetPedidosUseCase getPedidosUseCase;
  final CreatePedidoUseCase createPedidoUseCase;
  final UpdatePedidoUseCase updatePedidoUseCase;
  final DeletePedidoUseCase deletePedidoUseCase;

  List<Pedido> _pedidos = [];
  bool _isLoading = false;
  String? _error;

  // Shopping Cart logic for creating a new order
  List<PedidoDetalle> _currentCart = [];
  String _currentCliente = "";

  PedidoViewModel({
    required this.getPedidosUseCase,
    required this.createPedidoUseCase,
    required this.updatePedidoUseCase,
    required this.deletePedidoUseCase,
  });

  List<Pedido> get pedidos => _pedidos;
  bool get isLoading => _isLoading;
  String? get error => _error;
  List<PedidoDetalle> get currentCart => _currentCart;
  double get cartTotal => _currentCart.fold(0, (sum, item) => sum + item.subtotal);

  void setCliente(String nombre) {
    _currentCliente = nombre;
    notifyListeners();
  }

  void addToCart(Plato plato, int cantidad) {
    if (!plato.disponible) return;

    final index = _currentCart.indexWhere((item) => item.plato.id == plato.id);
    if (index >= 0) {
      final oldItem = _currentCart[index];
      final newCantidad = oldItem.cantidad + cantidad;
      _currentCart[index] = PedidoDetalle(
        plato: plato,
        cantidad: newCantidad,
        subtotal: plato.precio * newCantidad,
      );
    } else {
      _currentCart.add(PedidoDetalle(
        plato: plato,
        cantidad: cantidad,
        subtotal: plato.precio * cantidad,
      ));
    }
    notifyListeners();
  }

  void removeFromCart(int platoId) {
    _currentCart.removeWhere((item) => item.plato.id == platoId);
    notifyListeners();
  }

  void clearCart() {
    _currentCart = [];
    _currentCliente = "";
    notifyListeners();
  }

  Future<void> fetchPedidos() async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      _pedidos = await getPedidosUseCase.execute();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> confirmPedido() async {
    if (_currentCart.isEmpty) throw Exception("El pedido debe tener al menos un plato");
    if (_currentCliente.isEmpty) throw Exception("Debe ingresar el nombre del cliente");

    final newPedido = Pedido(
      cliente: _currentCliente,
      fecha: DateTime.now(),
      detalles: _currentCart,
      total: cartTotal,
    );

    try {
      await createPedidoUseCase.execute(newPedido);
      clearCart();
      await fetchPedidos();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      rethrow;
    }
  }

  Future<void> removePedido(int id) async {
    try {
      await deletePedidoUseCase.execute(id);
      await fetchPedidos();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      rethrow;
    }
  }
}
