import 'package:mdesk/view/dto/usuario.dart';

abstract class UsuarioInterfaceDAO {
  Future<Usuario> salvar(Usuario usuario);
  Future<List<Usuario>> consultarTodos();
}
