import 'package:flutter/material.dart';
import 'package:mdesk/database/sqlite/dao/manga_dao_sqlite.dart';
import 'package:mdesk/view/dto/manga.dart';
import 'package:mdesk/view/interface/manga_interface_dao.dart';
import 'package:mdesk/view/widget/botao.dart';
import 'package:mdesk/view/widget/campo_descricao.dart';
import 'package:mdesk/view/widget/campo_nome.dart';
import 'package:mdesk/view/widget/campo_opcoes_autor.dart';
import 'package:mdesk/view/widget/campo_opcoes_categoria.dart';
import 'package:mdesk/view/widget/campo_url.dart';

class MangaForm extends StatefulWidget {
  MangaForm({Key? key}) : super(key: key);

  @override
  State<MangaForm> createState() => _MangaFormState();
}

class _MangaFormState extends State<MangaForm> {
  final formKey = GlobalKey<FormState>();
  dynamic id;

  @override
  Widget build(BuildContext context) {
    receberMangaParaAlteracao(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro')),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            campoNome,
            campoDescricao,
            campoURL,
            campoCategoria,
            campoAutor,

            criarBotao(context),
          ],
        ),
      ),
    );
  }

  final campoNome = CampoNome(controle: TextEditingController());
  final campoDescricao = CampoDescricao(controle: TextEditingController());
  final campoURL = CampoURL(controle: TextEditingController());
  final campoCategoria = CampoOpcoesCategoria();
  final campoAutor = CampoOpcoesAutor();

  Widget criarBotao(BuildContext context) {
    return Botao(
      context: context,
      salvar: () {
        var formState = formKey.currentState;
        if (formState != null && formState.validate()) {
          var manga = preencherDTO();
          MangaInterfaceDAO dao = MangaDAOSQLite();
          dao.salvar(manga);
          Navigator.pop(context);
        }
      },
    );
  }

  void receberMangaParaAlteracao(BuildContext context) {
    var parametro = ModalRoute.of(context);
    if (parametro != null && parametro.settings.arguments != null) {
      Manga manga = parametro.settings.arguments as Manga;
      id = manga.id;
      preencherCampos(manga);
    }
  }

  Manga preencherDTO() {
    return Manga(
      id: id,
      nome: campoNome.controle.text,
      descricao: campoDescricao.controle.text,
      urlAvatar: campoURL.controle.text,
      categoria: campoCategoria.opcaoSelecionado!,
      autor:     campoAutor.opcaoSelecionado!,
    );
  }

  void preencherCampos(Manga manga) {
    campoNome.controle.text = manga.nome;
    campoDescricao.controle.text = manga.descricao;
    campoURL.controle.text = manga.urlAvatar;
    campoCategoria.opcaoSelecionado = manga.categoria;
    campoAutor.opcaoSelecionado = manga.autor;
  }
}
