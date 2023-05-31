import 'package:flutter/material.dart';
import 'package:mdesk/view/widget/dropdowm_buttom.dart';

class TelaTeste extends StatelessWidget {
  const TelaTeste({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tela de Teste'),
      ),
      body: Center(
        child: CustomDropdownButton(),
      ),
    );
  }
}
