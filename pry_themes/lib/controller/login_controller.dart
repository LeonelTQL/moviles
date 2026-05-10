import '../model/usuario_model.dart';
class LoginController {
  String? validar(UsuarioModel usuario){
    if(usuario.nombreUsuario.isEmpty || usuario.password.isEmpty){
      return "Completar datos";
    }
    return null;
  }

  //validar la autenticacion
  bool autenticar(UsuarioModel usuario){
    return usuario.nombreUsuario == 'leo' && usuario.password== '1234';
  }
}