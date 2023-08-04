/* import 'package:flutter/material.dart';
import 'package:mdesk/Rota.dart';
import 'package:mdesk/database/sqlite/dao/manga_dao_sqlite.dart';
import 'package:mdesk/view/dto/manga.dart';
import 'package:mdesk/view/interface/manga_interface_dao.dart';
import 'package:mdesk/view/widget/barra_navegacao.dart';
import 'package:mdesk/view/widget/botao_adicionar.dart';
import 'package:mdesk/view/widget/painel_botoes.dart';

class MangaLista extends StatefulWidget {
  const MangaLista({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MangaListaState();
}

class _MangaListaState extends State<MangaLista> {
  MangaInterfaceDAO dao = MangaDAOSQLite();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: criarLista(context),
      floatingActionButton: BotaoAdicionar(
          acao: () => Navigator.pushNamed(context, Rota.mangaForm)
              .then((value) => buscarMangas())),
      bottomNavigationBar: const BarraNavegacao(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget criarLista(BuildContext context) {
    return FutureBuilder(
      future: buscarMangas(),
      builder: (context, AsyncSnapshot<List<Manga>> lista) {
        if (!lista.hasData) return const CircularProgressIndicator();
        if (lista.data == null) return const Text('Não há Mangas');
        List<Manga> listaMangas = lista.data!;
        return ListView.builder(
          itemCount: listaMangas.length,
          itemBuilder: (context, indice) {
            var manga = listaMangas[indice];
            return criarItemLista(context, manga);
          },
        );
      },
    );
  }

  Future<List<Manga>> buscarMangas() {
    setState(() {});
    return dao.consultarTodos();
  }

  Widget criarItemLista(BuildContext context, Manga manga) {
    return ItemLista(
        manga: manga,
        alterar: () {
          Navigator.pushNamed(context, Rota.mangaForm, arguments: manga)
              .then((value) => buscarMangas());
        },
        detalhes: () {
          Navigator.pushNamed(context, Rota.mangaDetalhe, arguments: manga);
        },
        excluir: () {
          dao.excluir(manga.id);
          buscarMangas();
        });
  }
}

class ItemLista extends StatelessWidget {
  final Manga manga;
  final VoidCallback alterar;
  final VoidCallback detalhes;
  final VoidCallback excluir;

  const ItemLista(
      {required this.manga,
      required this.alterar,
      required this.detalhes,
      required this.excluir,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: FotoManga(manga: manga),
      title: Text(manga.nome),
      subtitle: Text(manga.descricao),
      trailing: PainelBotoes(alterar: alterar, excluir: excluir),
      onTap: detalhes,
    );
  }
}

class FotoManga extends StatelessWidget {
  final Manga manga;

  const FotoManga({required this.manga, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      manga.urlAvatar,
      height: 80,
      width: 80,
      errorBuilder: (context, error, stackTrace) {
        return Icon(Icons.error);
      },
    );
  }
} */
////
///
///
import 'package:flutter/material.dart';
import 'package:mdesk/Rota.dart';
import 'package:mdesk/database/sqlite/dao/manga_dao_sqlite.dart';
import 'package:mdesk/view/dto/manga.dart';
import 'package:mdesk/view/interface/manga_interface_dao.dart';
import 'package:mdesk/view/widget/barra_navegacao.dart';
import 'package:mdesk/view/widget/botao_adicionar.dart';
import 'package:mdesk/view/widget/painel_botoes.dart';

class MangaLista extends StatefulWidget {
  const MangaLista({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MangaListaState();
}

class _MangaListaState extends State<MangaLista> {
  MangaInterfaceDAO dao = MangaDAOSQLite();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: criarLista(context),
      floatingActionButton: BotaoAdicionar(
          acao: () => Navigator.pushNamed(context, Rota.mangaForm)
              .then((value) => buscarMangas())),
      bottomNavigationBar: const BarraNavegacao(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      
    );
  }

  Widget criarLista(BuildContext context) {
    return FutureBuilder(
      future: buscarMangas(),
      builder: (context, AsyncSnapshot<List<Manga>> lista) {
        if (!lista.hasData) return const CircularProgressIndicator();
        if (lista.data == null) return const Text('Não há Mangas');
        List<Manga> listaMangas = lista.data!;
        return ListView.builder(
          itemCount: listaMangas.length,
          itemBuilder: (context, indice) {
            var manga = listaMangas[indice];
            return criarItemLista(context, manga);
          },
        );
      },
    );
  }

  Future<List<Manga>> buscarMangas() {
    setState(() {});
    return dao.consultarTodos();
  }

  Widget criarItemLista(BuildContext context, Manga manga) {
    return ItemLista(
        manga: manga,
        alterar: () {
          Navigator.pushNamed(context, Rota.mangaForm, arguments: manga)
              .then((value) => buscarMangas());
        },
        detalhes: () {
          Navigator.pushNamed(context, Rota.mangaDetalhe, arguments: manga);
        },
        excluir: () {
          dao.excluir(manga.id);
          buscarMangas();
        });
  }
}

class ItemLista extends StatelessWidget {
  final Manga manga;
  final VoidCallback alterar;
  final VoidCallback detalhes;
  final VoidCallback excluir;

  const ItemLista(
      {required this.manga,
      required this.alterar,
      required this.detalhes,
      required this.excluir,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: FotoManga(manga: manga),
      title: Text(
        manga.nome,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        manga.descricao,
        style: TextStyle(
        ),
      ),
      trailing: PainelBotoes(alterar: alterar, excluir: excluir),
      onTap: detalhes,
    );
  }
}

class FotoManga extends StatelessWidget {
  final Manga manga;

  const FotoManga({required this.manga, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      manga.urlAvatar,
      height: 80,
      width: 80,
      errorBuilder: (context, error, stackTrace) {
        return Icon(Icons.error);
      },
    );
  }
}
