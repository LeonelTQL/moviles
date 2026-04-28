class EjercicioModelo {
  final int diferentes;
  final int suma;
  final double promedio;
  final int producto;
  final int restante;
  final bool divisionPor;

  EjercicioModelo(
      this.diferentes,
      this.suma,
      this.promedio,
      this.producto,
      this.restante,
      this.divisionPor);


  static EjercicioModelo calculos(int a, int b, int c) {
    final lista = [a, b, c];
    final suma = lista.reduce((x,y)=>x+y);
    final promedio=suma/3;
    final maximo=lista.reduce((x,y)=>x>y?x:y);
    final minimo=lista.reduce((x,y)=>x<y?x:y);
    final producto=maximo *minimo;

    final restante = suma - maximo - minimo;
    final diferentes= lista.toSet().length;
    final divisionPor= restante % 3 ==0;

    return EjercicioModelo(diferentes, suma, promedio, producto, restante, divisionPor);
  }
}