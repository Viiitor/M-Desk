import 'package:flutter/material.dart';
import 'package:mdesk/view/dto/manga.dart';
import 'package:mdesk/view/widget/foto_manga.dart';

class MangaDetalhe extends StatelessWidget {
  const MangaDetalhe({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Manga manga = receberManga(context);
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(60),
        children: [
          FotoManga(
            manga: manga,
            altura: 100,
            largura: 100,
          ),
          nome(manga),
          descricao(manga),
          categoria(manga),
          autor(manga),
        ],
      ),
      floatingActionButton: botaoVoltar(context),
    );
  }

  Manga receberManga(BuildContext context) {
    var parametro = ModalRoute.of(context);
    if (parametro != null) {
      Manga manga = parametro.settings.arguments as Manga;
      return manga;
    } else {
      throw Exception('Problemas em receber Manga');
    }
  }

  Widget nome(Manga manga) {
    return Center(
      child: Text(manga.nome, style: const TextStyle(fontSize: 30)),
    );
  }

  Widget descricao(Manga manga) {
    return Card(
      child: ListTile(
        title: const Text('Descrição:'),
        subtitle: Text(manga.descricao),
        trailing: painelDescricao(manga),
      ),
    );
  }

  Widget categoria(Manga manga) {
    final categoria = manga.categoria.nome;
    return Card(
      child: ListTile(
        title: const Text('Categorias'),
        subtitle: Text('${categoria}'),
      ),
    );
  }

    Widget autor(Manga manga) {
    final autor = manga.autor.nome;
    return Card(
      child: ListTile(
        title: const Text('Autor'),
        subtitle: Text('${autor}'),
      ),
    );
  }

  Widget painelDescricao(Manga manga) {
    return SizedBox(
      width: 100,
      child: Row(
        children: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.message)),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.description),
          )
        ],
      ),
    );
  }

  Widget botaoVoltar(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(Icons.arrow_back),
      onPressed: () => Navigator.pop(context),
    );
  }
}
