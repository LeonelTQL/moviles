import '../model/pago_model.dart';

class PagoController {

  String calcularPagoFinal({
    required String cliente,
    required String servicio,
    required String consumoString,
    required String formaPago,
    required bool checkMantenimiento,
    required bool checkSeguro,
    required bool checkDescuento,
  }) {

    if (cliente.isEmpty || consumoString.isEmpty) {
      return "Error: Faltan datos del cliente o consumo.";
    }

    final consumo = double.tryParse(consumoString);
    if (consumo == null || consumo < 0) {
      return "Error: Ingrese un valor válido.";
    }

    final pago = PagoModel(
      cliente: cliente,
      tipoServicio: servicio,
      consumoBase: consumo,
      formaPago: formaPago,
      aplicarMantenimiento: checkMantenimiento,
      aplicarSeguro: checkSeguro,
      aplicarDescuento: checkDescuento,
    );

    return pago.generarFactura();
  }
}