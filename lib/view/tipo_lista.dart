import 'package:flutter/material.dart';
import 'package:mdesk/Rota.dart';
import 'package:mdesk/database/sqlite/dao/tipo_dao_sqlite.dart';
import 'package:mdesk/view/dto/tipo.dart';
import 'package:mdesk/view/interface/tipo_interface_dao.dart';
import 'package:mdesk/view/widget/barra_navegacao.dart';
import 'package:mdesk/view/widget/botao_adicionar.dart';
import 'package:mdesk/view/widget/painel_botoes.dart';

class TipoLista extends StatefulWidget {
  const TipoLista({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TipoListaState();
}

class _TipoListaState extends State<TipoLista> {
  TipoInterfaceDAO dao = TipoDAOSQLite();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: criarLista(context),
      //floatingActionButton: BotaoAdicionar(
          //acao: () => Navigator.pushNamed(context, Rota.tipoForm)
              //.then((value) => buscarTipoes())),
      //bottomNavigationBar: const BarraNavegacao(),
      //floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget criarLista(BuildContext context) {
    return FutureBuilder(
        future: buscarTipoes(),
        builder: (context, AsyncSnapshot<List<Tipo>> lista) {
          if (!lista.hasData) return const CircularProgressIndicator();
          if (lista.data == null) return const Text('Não há Tipoes');
          List<Tipo> listaTipo = lista.data!;
          return ListView.builder(
            itemCount: listaTipo.length,
            itemBuilder: (context, indice) {
              var tipo = listaTipo[indice];
              return criarItemLista(context, tipo);
            },
          );
        });
  }

  Future<List<Tipo>> buscarTipoes() {
    setState(() {});
    return dao.consultarTodos();
  }

  Widget criarItemLista(BuildContext context, Tipo tipo) {
    return ItemLista(
        tipo: tipo,
        alterar: () {
          Navigator.pushNamed(context, Rota.tipoForm, arguments: tipo)
              .then((value) => buscarTipoes());
        },
        excluir: () {
          dao.excluir(tipo.id);
          buscarTipoes();
        });
  }
}

class ItemLista extends StatelessWidget {
  final Tipo tipo;
  final VoidCallback alterar;
  final VoidCallback excluir;

  const ItemLista(
      {required this.tipo,
      required this.alterar,
      required this.excluir,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(tipo.nome),
      //trailing: PainelBotoes(alterar: alterar, excluir: excluir),
    );
  }
}
