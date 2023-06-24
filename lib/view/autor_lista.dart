import 'package:flutter/material.dart';
import 'package:mdesk/Rota.dart';
import 'package:mdesk/database/sqlite/dao/autor_dao_sqlite.dart';
import 'package:mdesk/view/dto/autor.dart';
import 'package:mdesk/view/interface/autor_interface_dao.dart';
import 'package:mdesk/view/widget/barra_navegacao.dart';
import 'package:mdesk/view/widget/botao_adicionar.dart';
import 'package:mdesk/view/widget/painel_botoes.dart';

class AutorLista extends StatefulWidget {
  const AutorLista({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AutorListaState();
}

class _AutorListaState extends State<AutorLista> {
  AutorInterfaceDAO dao = AutorDAOSQLite();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: criarLista(context),
      floatingActionButton: BotaoAdicionar(
          acao: () => Navigator.pushNamed(context, Rota.autorForm)
              .then((value) => buscarAutores())),
      bottomNavigationBar: const BarraNavegacao(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget criarLista(BuildContext context) {
    return FutureBuilder(
        future: buscarAutores(),
        builder: (context, AsyncSnapshot<List<Autor>> lista) {
          if (!lista.hasData) return const CircularProgressIndicator();
          if (lista.data == null) return const Text('Não há Autores');
          List<Autor> listaAutor = lista.data!;
          return ListView.builder(
            itemCount: listaAutor.length,
            itemBuilder: (context, indice) {
              var autor = listaAutor[indice];
              return criarItemLista(context, autor);
            },
          );
        });
  }

  Future<List<Autor>> buscarAutores() {
    setState(() {});
    return dao.consultarTodos();
  }

  Widget criarItemLista(BuildContext context, Autor autor) {
    return ItemLista(
        autor: autor,
        alterar: () {
          Navigator.pushNamed(context, Rota.autorForm, arguments: autor)
              .then((value) => buscarAutores());
        },
        excluir: () {
          dao.excluir(autor.id);
          buscarAutores();
        });
  }
}

class ItemLista extends StatelessWidget {
  final Autor autor;
  final VoidCallback alterar;
  final VoidCallback excluir;

  const ItemLista(
      {required this.autor,
      required this.alterar,
      required this.excluir,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(autor.nome),
      trailing: PainelBotoes(alterar: alterar, excluir: excluir),
    );
  }
}
