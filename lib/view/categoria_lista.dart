import 'package:flutter/material.dart';
import 'package:mdesk/Rota.dart';
import 'package:mdesk/database/sqlite/dao/categoria_dao_sqlite.dart';
import 'package:mdesk/view/dto/categoria.dart';
import 'package:mdesk/view/interface/categoria_inteface_dao.dart';
import 'package:mdesk/view/widget/barra_navegacao.dart';
import 'package:mdesk/view/widget/botao_adicionar.dart';
import 'package:mdesk/view/widget/painel_botoes.dart';

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
      floatingActionButton: BotaoAdicionar(acao: () => Navigator.pushNamed(context, Rota.categoriaForm).then((value) => buscarCategorias())),
      bottomNavigationBar: const BarraNavegacao(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget criarLista(BuildContext context) {
    return FutureBuilder(
      future: buscarCategorias(),
      builder: (context, AsyncSnapshot<List<Categoria>> lista) {
        if (!lista.hasData) return const CircularProgressIndicator();
        if (lista.data == null) return const Text('Não há Categorias');
        List<Categoria> listaCategoria = lista.data!;
        return ListView.builder(
         itemCount: listaCategoria.length,
          itemBuilder: (context, indice) {
             var categoria = listaCategoria[indice];
             return criarItemLista(context, categoria);
          },
        );
      }
   );
  }




  Future<List<Categoria>> buscarCategorias() {
    setState(() {});
    return dao.consultarTodos();
  }

  Widget criarItemLista(BuildContext context, Categoria categoria) {
    return ItemLista(
        categoria: categoria,
        alterar: () {
          Navigator.pushNamed(context, Rota.categoriaForm, arguments: categoria)
              .then((value) => buscarCategorias());
        },
        excluir: () {
          dao.excluir(categoria.id);
          buscarCategorias();
        });
  }
}

class ItemLista extends StatelessWidget {
  final Categoria categoria;
  final VoidCallback alterar;
  final VoidCallback excluir;

  const ItemLista(
      {required this.categoria,
      required this.alterar,
      required this.excluir,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(categoria.nome),
      trailing: PainelBotoes(alterar: alterar, excluir: excluir),
    );
  }
}


