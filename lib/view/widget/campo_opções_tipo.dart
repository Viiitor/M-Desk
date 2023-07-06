import 'package:flutter/material.dart';
import 'package:mdesk/database/sqlite/dao/tipo_dao_sqlite.dart';
import 'package:mdesk/view/dto/tipo.dart';

// ignore: must_be_immutable
class CampoOpcoesTipo extends StatefulWidget {
  Tipo? opcaoSelecionado;
  CampoOpcoesTipo({Key? key}) : super(key: key);

  @override
  State<CampoOpcoesTipo> createState() => _CampoOpcoesTipoState();
}

class _CampoOpcoesTipoState extends State<CampoOpcoesTipo> {
  void associarTipo(Tipo tipo) {
    setState(() {
      widget.opcaoSelecionado = tipo;
    });
  }

  late Future<List<Tipo>> dadosBD;

  @override
  void initState() {
    super.initState();
    dadosBD = TipoDAOSQLite().consultarTodos();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: dadosBD,
        builder: (BuildContext context, AsyncSnapshot<List<Tipo>> resultado) {
          if (!resultado.hasData) return const CircularProgressIndicator();
          if (resultado.data == null)
            return const Text('Faça o cadastro do tipo primeiro.');
          List<Tipo> tipo = resultado.data!;
          List<DropdownMenuItem<Tipo>> itensTipo = tipo
              .map((tipo) =>
                  DropdownMenuItem(value: tipo, child: Text(tipo.nome)))
              .toList();
          return DropdownButtonFormField<Tipo>(
              hint: const Text('Tipos'),
              isExpanded: true,
              items: itensTipo,
              value: widget.opcaoSelecionado,
              onChanged: (tipoEscolhida) {
                if (tipoEscolhida != null) associarTipo(tipoEscolhida);
              });
        });
  }
}
