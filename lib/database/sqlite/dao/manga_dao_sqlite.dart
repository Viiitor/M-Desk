import 'package:mdesk/database/sqlite/conexao.dart';
import 'package:mdesk/database/sqlite/dao/autor_dao_sqlite.dart';
import 'package:mdesk/database/sqlite/dao/categoria_dao_sqlite.dart';
import 'package:mdesk/view/dto/autor.dart';
import 'package:mdesk/view/dto/categoria.dart';
import 'package:mdesk/view/dto/manga.dart';
import 'package:mdesk/view/interface/manga_interface_dao.dart';
import 'package:sqflite/sqlite_api.dart';

class MangaDAOSQLite implements MangaInterfaceDAO {


    @override
  Future<Manga> consultar(int id) async {
    Database db = await Conexao.criar();
    List<Map> maps =
        await db.query('Manga', where: 'id = ?', whereArgs: [id]);
    if (maps.isEmpty)
      throw Exception('Não foi encontrado registro com este id');
    Map<dynamic, dynamic> resultado = maps.first;
    return converterManga(resultado);
  }

    @override
  Future<List<Manga>> consultarTodos() async {
    Database db = await Conexao.criar();
    List<Manga> lista =
        (await db.query('manga')).map<Manga>(converterManga).toList();
    return lista;
  }

  @override
  Future<bool> excluir(id) async {
    Database db = await Conexao.criar();
    var sql = 'DELETE FROM manga WHERE id = ?';
    int linhasAfetas = await db.rawDelete(sql, [id]);
    return linhasAfetas > 0;
  }

  
  @override
  Future<Manga> salvar(Manga manga) async {
    Database db = await Conexao.criar();
    String sql;
    if (manga.id == null) {
      sql =
          'INSERT INTO manga (nome, descricao, url_avatar, categoria_id, autor_id) VALUES (?,?,?,?,?)';
      int id = await db.rawInsert(sql,
          [manga.nome, manga.descricao, manga.urlAvatar]);
      manga = Manga(
          id: id,
          nome: manga.nome,
          descricao: manga.descricao,
          urlAvatar: manga.urlAvatar,
          categoria: manga.categoria,
          autor:     manga.autor,
          );
    } else {
      sql =
          'UPDATE manga SET nome = ?, descricao =?, url_avatar= ?, categoria_id= ?, autor_id=? WHERE id = ?';
      db.rawUpdate(sql, [
        manga.nome,
        manga.descricao,
        manga.urlAvatar,
        manga.id,
        manga.categoria.id,
        manga.autor.id,
      ]);
    }
    return manga;
  }

    Future<Manga> converterManga(Map<dynamic, dynamic> resultado) async {
      Categoria categoria = await CategoriaDAOSQLite().consultar(resultado['categoria_id']);
      Autor autor = await AutorDAOSQLite().consultar(resultado['autor_id']);

    return Manga(
        id: resultado['id'],
        nome: resultado['nome'],
        descricao: resultado['descricao'],
        urlAvatar: resultado['url_avatar'],
        categoria: categoria,
        autor: autor,

        );
  }
}
