import 'package:flutter/material.dart';
import 'package:mdesk/database/sqlite/dao/autor_dao_sqlite.dart';
import 'package:mdesk/view/dto/autor.dart';

// ignore: must_be_immutable
class CampoOpcoesAutor extends StatefulWidget {
  Autor? opcaoSelecionado;
  CampoOpcoesAutor({Key? key}) : super(key: key);

  @override
  State<CampoOpcoesAutor> createState() => _CampoOpcoesAutorState();
}

class _CampoOpcoesAutorState extends State<CampoOpcoesAutor> {
  void associarAutor(Autor autor) {
    setState(() {
      widget.opcaoSelecionado = autor;
    });
  }

  late Future<List<Autor>> dadosBD;

  @override
  void initState() {
    super.initState();
    dadosBD = AutorDAOSQLite().consultarTodos();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: dadosBD,
        builder:
            (BuildContext context, AsyncSnapshot<List<Autor>> resultado) {
          if (!resultado.hasData) return const CircularProgressIndicator();
          if (resultado.data == null)
            return const Text('Faça o cadastro do autor primeiro.');
          List<Autor> autors = resultado.data!;
          List<DropdownMenuItem<Autor>> itensAutor = autors
              .map((autor) => DropdownMenuItem(
                  value: autor, child: Text(autor.nome)))
              .toList();
          return DropdownButtonFormField<Autor>(
              hint: const Text('Autores'),
              isExpanded: true,
              items: itensAutor,
              value: widget.opcaoSelecionado,
              onChanged: (autorEscolhida) {
                if (autorEscolhida != null)
                  associarAutor(autorEscolhida);
              });
        });
  }
}
