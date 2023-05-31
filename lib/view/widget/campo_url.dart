import 'package:flutter/material.dart';

class CampoURL extends StatelessWidget{
  final TextEditingController controle;
  const CampoURL({required this.controle, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return TextFormField(
      controller: controle,
      keyboardType: TextInputType.url,
      validator: (valorDigitado){
        return ehVazio(valorDigitado);
      },
      decoration: const InputDecoration(
        label: Text('URL Manga:'),
        hintText: 'URL da Imagem'
      ),
    );
  }

  String? ehVazio(String? valorDigitado){
    if(valorDigitado == null || valorDigitado.isEmpty) return 'O campo é obrigatorio';
    return null;
  }
}