import 'package:flutter/material.dart';
import 'package:mdesk/view/dto/categoria.dart';
import 'package:mdesk/view/widget/painel_botoes.dart';

class ItemLista extends StatelessWidget {
  final Categoria categoria;
  final VoidCallback alterar;
  final VoidCallback excluir;

  const ItemLista({
    required this.categoria,
    required this.alterar,
    required this.excluir,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(categoria.nome),
      trailing: PainelBotoes(
        alterar: alterar,
        excluir: excluir,
      ),
    );
  }
}
