import 'package:flutter/material.dart';
import 'package:mdesk/database/sqlite/dao/autor_dao_sqlite.dart';
import 'package:mdesk/view/dto/autor.dart';
import 'package:mdesk/view/interface/autor_interface_dao.dart';
import 'package:mdesk/view/widget/botao.dart';
import 'package:mdesk/view/widget/campo_nome.dart';


class AutorForm extends StatefulWidget {
  const AutorForm({Key? key}) : super(key: key);

  @override
  State<AutorForm> createState() => _AutorFormState();
}

class _AutorFormState extends State<AutorForm> {
  final formKey = GlobalKey<FormState>();
  dynamic id;
  final campoNome = CampoNome(controle: TextEditingController());


  @override
  Widget build(BuildContext context) {
    receberDadosParaAlteracao(context);
    return Scaffold(
        appBar: AppBar(title: const Text('Cadastro')),
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
          var autor = preencherDTO();
          AutorInterfaceDAO dao = AutorDAOSQLite();
          dao.salvar(autor);
          Navigator.pop(context);
        }
      },
    );
  }

  void receberDadosParaAlteracao(BuildContext context) {
    var parametro = ModalRoute.of(context);
    if (parametro != null && parametro.settings.arguments != null) {
      Autor autor = parametro.settings.arguments as Autor;
      id = autor.id;
      preencherCampos(autor);
    }
  }

  Autor preencherDTO() {
    return Autor(
        id: id,
        nome: campoNome.controle.text,);
  }

  void preencherCampos(Autor autor) {
    campoNome.controle.text = autor.nome;

  }
}
