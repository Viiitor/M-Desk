import 'package:flutter/material.dart';
import 'package:mdesk/database/sqlite/dao/tipo_dao_sqlite.dart';
import 'package:mdesk/view/dto/tipo.dart';
import 'package:mdesk/view/interface/tipo_interface_dao.dart';
import 'package:mdesk/view/widget/botao.dart';
import 'package:mdesk/view/widget/campo_nome.dart';

class TipoForm extends StatefulWidget {
  const TipoForm({Key? key}) : super(key: key);

  @override
  State<TipoForm> createState() => _TipoFormState();
}

class _TipoFormState extends State<TipoForm> {
  final formKey = GlobalKey<FormState>();
  dynamic id;
  final campoNome = CampoNome(controle: TextEditingController());

  @override
  Widget build(BuildContext context) {
    receberDadosParaAlteracao(context);
    return Scaffold(
        appBar: AppBar(title: const Text('Tipo')),
        body: Form(
            key: formKey,
            child: Column(
              children: [
                campoNome,
                criarBotao(context),
              ],
            )));
  }

  Widget criarBotao(BuildContext context) {
    return Botao(
      context: context,
      salvar: () {
        var formState = formKey.currentState;
        if (formState != null && formState.validate()) {
          var tipo = preencherDTO();
          TipoInterfaceDAO dao = TipoDAOSQLite();
          dao.salvar(tipo);
          Navigator.pop(context);
        }
      },
    );
  }

  void receberDadosParaAlteracao(BuildContext context) {
    var parametro = ModalRoute.of(context);
    if (parametro != null && parametro.settings.arguments != null) {
      Tipo tipo = parametro.settings.arguments as Tipo;
      id = tipo.id;
      preencherCampos(tipo);
    }
  }

  Tipo preencherDTO() {
    return Tipo(
      id: id,
      nome: campoNome.controle.text,
    );
  }

  void preencherCampos(Tipo tipo) {
    campoNome.controle.text = tipo.nome;
  }
}
