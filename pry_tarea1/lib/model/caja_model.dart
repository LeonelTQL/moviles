class CajaModelo {
  // Variables de estado
  double _totalClienteActual = 0.0;
  double _totalCajaDia = 0.0;
  int _clientesAtendidos = 0;

  // Getters para acceder a los datos sin modificarlos directamente
  double get totalClienteActual => _totalClienteActual;
  double get totalCajaDia => _totalCajaDia;
  int get clientesAtendidos => _clientesAtendidos;

  // Operaciones de negocio
  void agregarArticulo(double precio) {
    _totalClienteActual += precio;
  }

  double cerrarCobroCliente() {
    double montoAPagar = _totalClienteActual;

    // Acumulamos para el supervisor y reseteamos para el próximo cliente
    _totalCajaDia += montoAPagar;
    _clientesAtendidos++;
    _totalClienteActual = 0.0;

    return montoAPagar;
  }
}