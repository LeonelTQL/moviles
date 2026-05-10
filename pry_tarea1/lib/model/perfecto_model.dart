
class perfectoModel {
  bool esPerfecto(int numero) {
    if (numero <= 1) {
      return false;
    }

    int suma = 0;
    for (int i = 1; i < numero; i++) {
      if (numero % i == 0) {
        suma += i;
      }
    }
    return suma == numero;
  }
}