import 'package:mdesk/database/sqlite/conexao.dart';
import 'package:mdesk/view/dto/categoria.dart';
import 'package:mdesk/view/interface/categoria_inteface_dao.dart';
import 'package:sqflite/sqlite_api.dart';

class CategoriaDAOSQLite implements CategoriaInterfaceDAO {


  @override
  Future<Categoria> consultar(int id) async {
    Database db = await Conexao.criar();
    Map resultado =
        (await db.query('Categoria', where: 'id = ?', whereArgs: [id])).first;
    if (resultado.isEmpty)
      throw Exception('Não foi encontrado registro com este id');
    return converterCategoria(resultado);

    }

  @override
  Future<List<Categoria>> consultarTodos() async {
    Database db = await Conexao.criar();
    List<Map<dynamic, dynamic>> resultadoBD = await db.query('categoria');
    List<Categoria> lista = [];
    for (var registro in resultadoBD) {
      var categoria = await converterCategoria(registro);
      lista.add(categoria);
    }
  return lista;
  }

  @override
  Future<bool> excluir(id) async {
    Database db = await Conexao.criar();
    var sql = 'DELETE FROM categoria WHERE id = ?';
    int linhasAfetadas = await db.rawDelete(sql, [id]);
    return linhasAfetadas > 0;
  }

  @override
  Future<Categoria> salvar(Categoria categoria) async {
    Database db = await Conexao.criar();
    String sql;
    if (categoria.id == null) {
      sql = 'INSERT INTO categoria (nome) VALUES (?)';
      int id = await db.rawInsert(sql, [categoria.nome]);
      categoria = Categoria(
        id: id,
        nome: categoria.nome,
      );
    } else {
      sql = 'UPDATE categoria SET nome = ? WHERE id = ?';
      db.rawUpdate(sql, [categoria.nome, categoria.id]);
    }
    return categoria;
  }

  Categoria converterCategoria(Map<dynamic, dynamic> resultado) {
    return Categoria(
      id: resultado['id'],
      nome: resultado['nome'],
    );
  }
}
