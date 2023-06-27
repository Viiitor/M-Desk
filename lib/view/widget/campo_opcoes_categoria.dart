import 'package:flutter/material.dart';
import 'package:mdesk/database/sqlite/dao/categoria_dao_sqlite.dart';
import 'package:mdesk/view/dto/categoria.dart';


// ignore: must_be_immutable
class CampoOpcoesCategoria extends StatefulWidget {
  Categoria? opcaoSelecionado;
  CampoOpcoesCategoria({Key? key}) : super(key: key);

  @override
  State<CampoOpcoesCategoria> createState() => _CampoOpcoesCategoriaState();
}

class _CampoOpcoesCategoriaState extends State<CampoOpcoesCategoria> {
  void associarCategoria(Categoria categoria) {
    setState(() {
      widget.opcaoSelecionado = categoria;
    });
  }

  late Future<List<Categoria>> dadosBD;

  @override
  void initState() {
    super.initState();
    dadosBD = CategoriaDAOSQLite().consultarTodos();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: dadosBD,
        builder: (BuildContext context, AsyncSnapshot<List<Categoria>> resultado) {
          if (!resultado.hasData) return const CircularProgressIndicator();
          if (resultado.data == null)
            return const Text('Faça o cadastro de categoria primeiro.');
          List<Categoria> categorias = resultado.data!;
          List<DropdownMenuItem<Categoria>> itensCategoria = categorias
              .map((categoria) =>
                  DropdownMenuItem(value: categoria, child: Text(categoria.nome)))
              .toList();
          return DropdownButtonFormField<Categoria>(
              hint: const Text('Categorias'),
              isExpanded: true,
              items: itensCategoria,
              value: widget.opcaoSelecionado,
              onChanged: (categoriaEscolhida) {
                if (categoriaEscolhida != null) associarCategoria(categoriaEscolhida);
              });
        });
  }
}
