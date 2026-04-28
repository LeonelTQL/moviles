import 'dart:io';


void main(){
  // stdout.write("Ingrese el primer valor");
  // int n1=int.parse(stdin.readLineSync()!);
  // stdout.write("Ingrese el segundo valor");
  // int n2=int.parse(stdin.readLineSync()!);
  // stdout.write("Ingrese el tercer valor");
  // int n3=int.parse(stdin.readLineSync()!);
  //
  // if(n1<n2 && n2<n3){
  //   print("Los numero estan en orden ascendente");
  // }else{
  //   print("Los numero no estan en orden ascendente");
  //
  // }

    double kilos;
    int preciokg = 2;
    double descuento = 0;

    stdout.write("Ingrese los kilos a comprar: ");

    String input = stdin.readLineSync()!;
    kilos = double.parse(input);


    if (kilos <= 2) {
      descuento = 0;
    } else if (kilos <= 5) {
      descuento = 10;
    } else if (kilos <= 10) {
      descuento = 15;
    } else {
      descuento = 20;
    }

    double total = kilos * preciokg;
    double precioFinal = total * (1 - descuento / 100);

    print("Kilos: $kilos kg");
    print("Descuento aplicado: $descuento%");
    print("Total a pagar: \$${precioFinal.toStringAsFixed(2)}");
  }

