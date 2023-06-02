import 'package:flutter/material.dart';
import 'package:mdesk/database/sqlite/dao/categoria_dao_sqlite.dart';
import 'package:mdesk/view/dto/categoria.dart';
import 'package:mdesk/view/interface/categoria_inteface_dao.dart';
import 'package:mdesk/view/widget/barra_navegacao.dart';
import 'package:mdesk/view/widget/botao_adicionar.dart';
import 'package:mdesk/view/widget/item_lista.dart';

class CategoriaLista extends StatefulWidget {
  const CategoriaLista({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CategoriaListaState();
}

class _CategoriaListaState extends State<CategoriaLista> {
  CategoriaInterfaceDAO dao = CategoriaDAOSQLite();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lista Categorias')),
      body: criarLista(context),
      floatingActionButton: BotaoAdicionar(
        acao: () => Navigator.pushNamed(context, '/categoria-form')
            .then((value) => buscarCategorias()),
      ),
      bottomNavigationBar: const BarraNavegacao(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget criarLista(BuildContext context) {
    return FutureBuilder<List<Categoria>>(
      future: buscarCategorias(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const CircularProgressIndicator();
        if (snapshot.data == null) return const Text('Não há Categorias');
        List<Categoria> listaCategorias = snapshot.data!;
        return ListView.builder(
          itemCount: listaCategorias.length,
          itemBuilder: (context, index) {
            var categoria = listaCategorias[index];
            return ItemLista(
              categoria: categoria,
              alterar: () {
                Navigator.pushNamed(context, '/categoria-form',
                        arguments: categoria)
                    .then((value) => buscarCategorias());
              },
              excluir: () {
                dao.excluir(categoria.id);
                buscarCategorias();
              },
            );
          },
        );
      },
    );
  }

  Future<List<Categoria>> buscarCategorias() {
    setState(() {});
    return dao.consultarTodos();
  }
}
