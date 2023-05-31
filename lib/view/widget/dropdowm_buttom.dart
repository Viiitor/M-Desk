import 'package:flutter/material.dart';

class CustomDropdownButton extends StatefulWidget {
  CustomDropdownButton({Key? key}) : super(key: key);

  @override
  _CustomDropdownButtonState createState() => _CustomDropdownButtonState();
}

class _CustomDropdownButtonState extends State<CustomDropdownButton> {
  final dropValue = ValueNotifier('');
  final TextEditingController novaCategoriaController = TextEditingController();
  List<String> categoriasAdicionadas = [];

  @override
  void dispose() {
    dropValue.dispose();
    novaCategoriaController.dispose();
    super.dispose();
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
                      label: Text(categoria),
                      onDeleted: () => removerCategoria(categoria),
                    ))
                .toList(),
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

  void adicionarCategoria() {
    final novaCategoria = novaCategoriaController.text.trim();
    if (novaCategoria.isNotEmpty) {
      setState(() {
        categoriasAdicionadas.add(novaCategoria);
      });
      novaCategoriaController.clear();
    }
  }

  void removerCategoria(String categoria) {
    setState(() {
      categoriasAdicionadas.remove(categoria);
    });
  }
}
