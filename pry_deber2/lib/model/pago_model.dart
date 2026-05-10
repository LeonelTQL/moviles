class PagoModel {
  final String cliente;
  final String tipoServicio;
  final double consumoBase;
  final String formaPago;
  final bool aplicarMantenimiento;
  final bool aplicarSeguro;
  final bool aplicarDescuento;

  PagoModel({
    required this.cliente,
    required this.tipoServicio,
    required this.consumoBase,
    required this.formaPago,
    required this.aplicarMantenimiento,
    required this.aplicarSeguro,
    required this.aplicarDescuento,
  });

  double calcularSubtotal() {
    double tarifaMultiplicador = 1.0;

    if (tipoServicio == 'Agua') tarifaMultiplicador = 0.50;
    if (tipoServicio == 'Energía eléctrica') tarifaMultiplicador = 0.15;

    return consumoBase * tarifaMultiplicador;
  }


  double calcularDescuentos() {
    if (aplicarDescuento) {
      return calcularSubtotal() * 0.50;
    }
    return 0.0;
  }


  double calcularRecargos() {
    double recargos = 0;

    if (formaPago == 'Tarjeta') {
      recargos += calcularSubtotal() * 0.10;
    }

    if (aplicarMantenimiento) recargos += 5.00;
    if (aplicarSeguro) recargos += 3.50;

    return recargos;
  }

  double calcularTotal() {
    return calcularSubtotal() - calcularDescuentos() + calcularRecargos();
  }

  String generarFactura() {
    final subtotal = calcularSubtotal();
    final descuentos = calcularDescuentos();
    final recargos = calcularRecargos();
    final total = calcularTotal();

    return '''
      Cliente: $cliente
      Servicio: $tipoServicio
      Pago vía: $formaPago
      
      Subtotal: \$${subtotal.toStringAsFixed(2)}
      Descuentos: -\$${descuentos.toStringAsFixed(2)}
      Recargos: +\$${recargos.toStringAsFixed(2)}
      --------------------------------
      TOTAL A PAGAR: \$${total.toStringAsFixed(2)}
      ''';
  }
}