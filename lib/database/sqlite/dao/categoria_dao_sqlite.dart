import 'package:flutter/material.dart';
import 'package:mdesk/database/sqlite/conexao.dart';
import 'package:mdesk/view/dto/categoria.dart';
import 'package:mdesk/view/interface/categoria_inteface_dao.dart';
import 'package:sqflite/sqlite_api.dart';

class CategoriaDAOSQLite implements CategoriaInterfaceDAO {
  @override
  Future<Categoria> salvar(Categoria categoria) async {
    Database db = await Conexao.criar();
    String sql;
    if (categoria.id == null) {
      sql = 'INSERT INTO categoria (nome) VALUES (?)';
      int id = await db.rawInsert(sql, [categoria.nome]);
      categoria = Categoria(id: id, nome: categoria.nome);
    } else {
      sql = 'UPDATE categoria SET nome = ? WHERE id = ?';
      await db.rawUpdate(sql, [categoria.nome, categoria.id]);
    }
    return categoria;
  }

  @override
  Future<bool> excluir(dynamic id) async {
    Database db = await Conexao.criar();
    var sql = 'DELETE FROM categoria WHERE id = ?';
    int linhasAfetadas = await db.rawDelete(sql, [id]);
    return linhasAfetadas > 0;
  }
}

class CustomDropdownButton extends StatefulWidget {
  CustomDropdownButton({Key? key}) : super(key: key);

  @override
  _CustomDropdownButtonState createState() => _CustomDropdownButtonState();
}

class _CustomDropdownButtonState extends State<CustomDropdownButton> {
  final dropValue = ValueNotifier('');
  final TextEditingController novaCategoriaController = TextEditingController();
  List<Categoria> categoriasAdicionadas = [];

  CategoriaInterfaceDAO categoriaDAO = CategoriaDAOSQLite();

  @override
  void dispose() {
    dropValue.dispose();
    novaCategoriaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categorias'),
        elevation: 0,
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          Text(
            'Categorias adicionadas:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: categoriasAdicionadas
                .map((categoria) => Chip(
                      label: Text(categoria.nome),
                      onDeleted: () => removerCategoria(categoria),
                    ))
                .toList(),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: novaCategoriaController,
            decoration: InputDecoration(
              hintText: 'Digite o nome da nova categoria',
            ),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: adicionarCategoria,
            child: Text('Adicionar Categoria'),
          ),
        ],
      ),
    );
  }

  void adicionarCategoria() async {
    final novoNomeCategoria = novaCategoriaController.text.trim();
    if (novoNomeCategoria.isNotEmpty) {
      Categoria novaCategoria = Categoria(nome: novoNomeCategoria);
      Categoria categoriaSalva = await categoriaDAO.salvar(novaCategoria);
      setState(() {
        categoriasAdicionadas.add(categoriaSalva);
      });
      novaCategoriaController.clear();
    }
  }

  void removerCategoria(Categoria categoria) async {
    await categoriaDAO.excluir(categoria.id);
    setState(() {
      categoriasAdicionadas.remove(categoria);
    });
  }
}
