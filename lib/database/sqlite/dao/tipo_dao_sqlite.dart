import 'package:mdesk/database/sqlite/conexao.dart';
import 'package:mdesk/view/dto/tipo.dart';
import 'package:mdesk/view/interface/tipo_interface_dao.dart';
import 'package:sqflite/sqlite_api.dart';

class TipoDAOSQLite implements TipoInterfaceDAO {
  @override
  Future<Tipo> consultar(int id) async {
    Database db = await Conexao.criar();
    Map resultado =
        (await db.query('Tipo', where: 'id = ?', whereArgs: [id])).first;
    if (resultado.isEmpty)
      throw Exception('Não foi encontrado registro com este id');
    return converterTipo(resultado);
  }

  @override
  Future<List<Tipo>> consultarTodos() async {
    Database db = await Conexao.criar();
    List<Map<dynamic, dynamic>> resultadoBD = await db.query('tipo');
    List<Tipo> lista = [];
    for (var registro in resultadoBD) {
      var categoria = await converterTipo(registro);
      lista.add(categoria);
    }
    return lista;
  }

  @override
  Future<bool> excluir(id) async {
    Database db = await Conexao.criar();
    var sql = 'DELETE FROM tipo WHERE id = ?';
    int linhasAfetadas = await db.rawDelete(sql, [id]);
    return linhasAfetadas > 0;
  }

  @override
  Future<Tipo> salvar(Tipo tipo) async {
    Database db = await Conexao.criar();
    String sql;
    if (tipo.id == null) {
      sql = 'INSERT INTO tipo (nome) VALUES (?)';
      int id = await db.rawInsert(sql, [tipo.nome]);
      tipo = Tipo(
        id: id,
        nome: tipo.nome,
      );
    } else {
      sql = 'UPDATE tipo SET nome = ? WHERE id = ?';
      db.rawUpdate(sql, [tipo.nome, tipo.id]);
    }
    return tipo;
  }

  Tipo converterTipo(Map<dynamic, dynamic> resultado) {
    return Tipo(
      id: resultado['id'],
      nome: resultado['nome'],
    );
  }
}
