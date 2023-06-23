import 'package:mdesk/database/sqlite/conexao.dart';
import 'package:mdesk/view/dto/autor.dart';
import 'package:mdesk/view/interface/autor_interface_dao.dart';
import 'package:sqflite/sqlite_api.dart';

class AutorDAOSQLite implements AutorInterfaceDAO {
  @override
  Future<Autor> consultar(int id) async {
    Database db = await Conexao.criar();
    List<Map> maps =
        await db.query('Autor', where: 'id = ?', whereArgs: [id]);
    if (maps.isEmpty)
      throw Exception('Não foi encontrado registro com este id');
    Map<dynamic, dynamic> resultado = maps.first;
    return converterAutor(resultado);
  }

  @override
  Future<List<Autor>> consultarTodos() async {
    Database db = await Conexao.criar();
    List<Autor> lista = (await db.query('autor'))
        .map<Autor>(converterAutor)
        .toList();
    return lista;
  }

  @override
  Future<bool> excluir(id) async {
    Database db = await Conexao.criar();
    var sql = 'DELETE FROM autor WHERE id = ?';
    int linhasAfetadas = await db.rawDelete(sql, [id]);
    return linhasAfetadas > 0;
  }

  @override
  Future<Autor> salvar(Autor autor) async {
    Database db = await Conexao.criar();
    String sql;
    if (autor.id == null) {
      sql = 'INSERT INTO autor (nome) VALUES (?)';
      int id = await db.rawInsert(sql, [autor.nome]);
      autor = Autor(
        id: id,
        nome: autor.nome,
      );
    } else {
      sql = 'UPDATE autor SET nome = ? WHERE id = ?';
      db.rawUpdate(sql, [autor.nome, autor.id]);
    }
    return autor;
  }

  Autor converterAutor(Map<dynamic, dynamic> resultado) {
    return Autor(
      id: resultado['id'],
      nome: resultado['nome'],
    );
  }
}
