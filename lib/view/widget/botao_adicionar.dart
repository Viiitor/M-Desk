import 'package:flutter/material.dart';

class BotaoAdicionar extends StatelessWidget{
  final VoidCallback acao;
  const BotaoAdicionar({required this.acao, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return FloatingActionButton(
      onPressed: () => acao(),
      tooltip: 'Adicionar Novo',
      backgroundColor: Color.fromARGB(255, 1, 7, 102),
      child: const Icon(Icons.add),
      );
  }
}