class VendedorModel {
  final double venta1;
  final double venta2;
  final double venta3;

  VendedorModel(this.venta1, this.venta2, this.venta3);


  double calcularSueldo(){
    double totalVentas = venta1 + venta2 + venta3;
    double sueldoBase = 482;
    double comision = totalVentas * 0.12;
    return sueldoBase + comision;
  }
}


