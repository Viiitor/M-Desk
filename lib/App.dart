import 'package:flutter/material.dart';
import 'package:mdesk/Rota.dart';
import 'package:mdesk/view/TelaTeste.dart';
import 'package:mdesk/view/manga_detalhe.dart';
import 'package:mdesk/view/manga_form.dart';
import 'package:mdesk/view/manga_lista.dart';
import 'package:mdesk/view/TelaInicial.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'MDesk', routes: {
      Rota.TelaInicial: (context) => TelaInicial(),
      Rota.mangaLista: (context) => MangaLista(),
      Rota.mangaForm: (context) => MangaForm(),
      Rota.mangaDetalhe: (context) => MangaDetalhe(),
      Rota.TelaTeste: (context) => TelaTeste(),
    });
  }
}
