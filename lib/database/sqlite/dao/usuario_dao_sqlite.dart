import 'package:mdesk/view/dto/usuario.dart';
import 'package:mdesk/view/interface/usuario_interface.dart';
import 'package:sqflite/sqflite.dart';

import '../conexao.dart';

class UsuarioDAOSQLite implements UsuarioInterfaceDAO {
  @override
  Future<Usuario> salvar(Usuario usuario) async {
    Database db = await Conexao.criar();
    String sql;
    if (usuario.id == null) {
      sql = 'INSERT INTO Usuario (usuario, email, senha) VALUES (?,?,?)';
      int id = await db
          .rawInsert(sql, [usuario.usuario, usuario.email, usuario.senha]);
      usuario = Usuario(
          id: id,
          usuario: usuario.usuario,
          email: usuario.email,
          senha: usuario.senha);
    } else {
      sql = 'UPDATE Usuario SET usuario = ?, email = ?, senha = ? WHERE id = ?';
      db.rawUpdate(
          sql, [usuario.usuario, usuario.email, usuario.senha, usuario.id]);
    }
    return usuario;
  }

  @override
  Future<List<Usuario>> consultarTodos() async {
    Database db = await Conexao.criar();
    List<Map<dynamic, dynamic>> resultadoBD = await db.query('usuario');
    List<Usuario> lista = [];
    for (var registro in resultadoBD) {
      var usuario = await converterUsuarios(registro);
      lista.add(usuario);
    }
    return lista;
  }

  Future<Usuario> converterUsuarios(Map<dynamic, dynamic> resultado) async {
    return Usuario(
        usuario: resultado['usuario'],
        email: resultado['email'],
        senha: resultado['senha']);
  }
}
