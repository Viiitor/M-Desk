import 'package:flutter/material.dart';
import 'package:mdesk/database/sqlite/dao/categoria_dao_sqlite.dart';
import 'package:mdesk/view/dto/categoria.dart';
import 'package:mdesk/view/interface/categoria_inteface_dao.dart';
import 'package:mdesk/view/widget/botao.dart';
import 'package:mdesk/view/widget/campo_nome.dart';

class CategoriaForm extends StatefulWidget {
  CategoriaForm({Key? key}) : super(key: key);

  @override
  State<CategoriaForm> createState() => _CategoriaFormState();
}

class _CategoriaFormState extends State<CategoriaForm> {
  final otherKey = GlobalKey<FormState>();
  dynamic id;

  @override
  Widget build(BuildContext context) {
    receberCategoriaParaAlteracao(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Categorias')),
      body: Form(
        key: otherKey,
        child: Column(
          children: [
            campoNome,
            criarBotao(context),
          ],
        ),
      ),
    );
  }

  final campoNome = CampoNome(controle: TextEditingController());

  Widget criarBotao(BuildContext context) {
    return Botao(
      context: context,
      salvar: () async {
        var formState = otherKey.currentState;
        if (formState != null && formState.validate()) {
          var categoria = preencherDTO();
          CategoriaInterfaceDAO dao = CategoriaDAOSQLite();
          await dao.salvar(categoria);
          Navigator.pop(context);
        }
      },
    );
  }

  void receberCategoriaParaAlteracao(BuildContext context) {
    var parametro = ModalRoute.of(context);
    if (parametro != null && parametro.settings.arguments != null) {
      Categoria categoria = parametro.settings.arguments as Categoria;
      id = categoria.id;
      preencherCampos(categoria);
    }
  }

  Categoria preencherDTO() {
    return Categoria(
      id: id,
      nome: campoNome.controle.text,
    );
  }

  void preencherCampos(Categoria categoria) {
    campoNome.controle.text = categoria.nome;
  }
}
