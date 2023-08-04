import 'package:flutter/material.dart';
import 'package:mdesk/Rota.dart';
import 'package:mdesk/view/autor_form.dart';
import 'package:mdesk/view/autor_lista.dart';
import 'package:mdesk/view/categoria_form.dart';
import 'package:mdesk/view/categoria_lista.dart';
import 'package:mdesk/view/home.dart';
import 'package:mdesk/view/manga_detalhe.dart';
import 'package:mdesk/view/manga_form.dart';
import 'package:mdesk/view/manga_lista.dart';
import 'package:mdesk/view/TelaInicial.dart';
import 'package:mdesk/view/tipo_form.dart';
import 'package:mdesk/view/tipo_lista.dart';
import 'package:mdesk/view/usuario_form.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'MDesk', routes: {
      Rota.TelaInicial: (context) => const TelaInicial(),
      Rota.home: (context) => const Home(),
      Rota.mangaLista: (context) => const MangaLista(),
      Rota.mangaForm: (context) => MangaForm(),
      Rota.mangaDetalhe: (context) => const MangaDetalhe(),
      Rota.categoriaLista: (context) => const CategoriaLista(),
      Rota.categoriaForm: (context) => CategoriaForm(),
      Rota.autorLista: (context) => const AutorLista(),
      Rota.autorForm: (context) => const AutorForm(),
      Rota.tipoLista: (context) => const TipoLista(),
      Rota.tipoForm: (context) => const TipoForm(),
      Rota.usuarioForm: (context) => const UsuarioForm(),
    });
  }
}
