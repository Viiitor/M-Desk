import 'package:flutter/material.dart';
import 'package:mdesk/view/autor_lista.dart';
import 'package:mdesk/view/categoria_lista.dart';
import 'package:mdesk/view/manga_lista.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        appBar: AppBar(title: const Text('M Desk'), bottom: opcoes()),
        body: const TabBarView(
          children: <Widget>[
            MangaLista(),
            CategoriaLista(),
            AutorLista(),
          ],
        ),
      ),
    );
  }

  TabBar opcoes() {
    return const TabBar(
      tabs: <Widget>[
        Tab(icon: Icon(Icons.import_contacts)),
        Tab(icon: Icon(Icons.space_dashboard)),
        Tab(icon: Icon(Icons.recent_actors)),
      ],
    );
  }
}
