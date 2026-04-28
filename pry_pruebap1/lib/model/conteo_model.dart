class conteoModelo {
  final int menores15;
  final int mayores50;
  final int entre25y45;
  final double promedio;

  conteoModelo(
      this.menores15,
      this.mayores50,
      this.entre25y45,
      this.promedio,
      );

  static conteoModelo analizar(List<int> numeros) {
    int menores15 = 0;
    int mayores50 = 0;
    int entre25y45 = 0;
    int suma = 0;

    for (var n in numeros) {
      if (n < 15) menores15++;
      if (n > 50) mayores50++;
      if (n >= 25 && n <= 45) entre25y45++;

      suma += n;
    }

    final promedio = suma / numeros.length;

    return conteoModelo(
      menores15,
      mayores50,
      entre25y45,
      promedio,
    );
  }
}