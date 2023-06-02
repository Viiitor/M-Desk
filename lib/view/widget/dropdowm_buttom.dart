import 'package:flutter/material.dart';
import 'package:mdesk/database/sqlite/dao/categoria_dao_sqlite.dart';
import 'package:mdesk/view/dto/categoria.dart';
import 'package:mdesk/view/interface/categoria_inteface_dao.dart';

class CustomDropdownButton extends StatefulWidget {
  CustomDropdownButton({Key? key}) : super(key: key);

  @override
  _CustomDropdownButtonState createState() => _CustomDropdownButtonState();
}

class _CustomDropdownButtonState extends State<CustomDropdownButton> {
  final TextEditingController novaCategoriaController = TextEditingController();
  List<Categoria> categoriasAdicionadas = [];
  Categoria? categoriaSelecionada;
  CategoriaInterfaceDAO dao = CategoriaDAOSQLite();

  @override
  void dispose() {
    novaCategoriaController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    buscarCategorias();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categorias'),
        elevation: 0,
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          Text(
            'Categorias adicionadas:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: categoriasAdicionadas
                .map((categoria) => Chip(
                      label: Text(categoria.nome),
                      onDeleted: () => removerCategoria(categoria),
                    ))
                .toList(),
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<Categoria>(
            value: categoriaSelecionada,
            onChanged: (Categoria? newValue) {
              setState(() {
                categoriaSelecionada = newValue;
              });
            },
            items: categoriasAdicionadas.map((Categoria categoria) {
              return DropdownMenuItem<Categoria>(
                value: categoria,
                child: Text(categoria.nome),
              );
            }).toList(),
            decoration: InputDecoration(
              labelText: 'Categoria',
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: novaCategoriaController,
            decoration: InputDecoration(
              hintText: 'Digite o nome da nova categoria',
            ),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: adicionarCategoria,
            child: Text('Adicionar Categoria'),
          ),
        ],
      ),
    );
  }

  Future<void> buscarCategorias() async {
    final List<Categoria> categorias = await dao.consultarTodos();
    setState(() {
      categoriasAdicionadas = categorias;
    });
  }

  void adicionarCategoria() async {
    final novaCategoriaNome = novaCategoriaController.text.trim();
    if (novaCategoriaNome.isNotEmpty) {
      final novaCategoria = Categoria(id: 0, nome: novaCategoriaNome);
      final Categoria categoriaSalva = await dao.salvar(novaCategoria);
      setState(() {
        categoriasAdicionadas.add(categoriaSalva);
        categoriaSelecionada = categoriaSalva;
      });
      novaCategoriaController.clear();
    }
  }

  void removerCategoria(Categoria categoria) async {
    await dao.excluir(categoria.id!);
    setState(() {
      categoriasAdicionadas.remove(categoria);
      if (categoriaSelecionada?.id == categoria.id) {
        categoriaSelecionada = null;
      }
    });
  }
}
