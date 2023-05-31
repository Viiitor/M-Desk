import 'package:flutter/material.dart';

class CampoDescricao extends StatelessWidget{
  final int maximoLinhas;
  final mascara = '[A-Za-z\u00C0-\u00FF]';
  final TextEditingController controle;
  const CampoDescricao({required this.controle, this.maximoLinhas = 5, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return TextFormField(
      controller: controle,
      keyboardType: TextInputType.multiline,
      maxLines: maximoLinhas,
      decoration: InputDecoration(
        labelText: 'Descrição',
        hintText: 'Digite uma Descrição'
      ),
    );
  }
}