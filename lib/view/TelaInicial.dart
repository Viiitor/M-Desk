import 'package:flutter/material.dart';
import 'package:mdesk/database/sqlite/conexao.dart';
import 'package:mdesk/view/dto/usuario.dart';
import 'package:sqflite/sqlite_api.dart';

class TelaInicial extends StatefulWidget {
  const TelaInicial({Key? key}) : super(key: key);

  @override
  _TelaInicialState createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {
  final _formKey = GlobalKey<FormState>();
  final _usuarioController = TextEditingController();
  final _senhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('M Desk'),
        backgroundColor: Color.fromARGB(255, 1, 7, 102), // Azul escuro marinho
      ),
      backgroundColor: Colors.grey[900], // Dark grey para o fundo da página
      body: Center(
        child: Container(
          width: 250,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'M Desk',
                  style: TextStyle(
                    color: Colors.white, // Texto branco
                    fontSize: 55,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: _usuarioController,
                  decoration: InputDecoration(
                    labelText: 'Usuário',
                    labelStyle: TextStyle(color: Colors.grey[300]),
                    enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.grey), // Altere a cor aqui
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.grey), // Altere a cor aqui
                    ),
                  ),
                  style: TextStyle(color: Colors.grey[300]),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, digite o usuário';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 30),
                TextFormField(
                  controller: _senhaController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    labelStyle: TextStyle(color: Colors.grey[300]),
                    enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.grey), // Altere a cor aqui
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.grey), // Altere a cor aqui
                    ),
                  ),
                  style: TextStyle(color: Colors.grey[300]),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, digite a senha';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 50),
                Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            String usuarioDigitado = _usuarioController.text;
                            String senhaDigitada = _senhaController.text;

                            Database db = await Conexao.criar();
                            List<Map<String, dynamic>> maps = await db.query(
                              'usuario',
                              where: 'usuario = ?',
                              whereArgs: [usuarioDigitado],
                            );

                            if (maps.isNotEmpty) {
                              Usuario usuarioEncontrado =
                                  Usuario.fromMap(maps.first);
                              if (usuarioEncontrado.senha == senhaDigitada) {
                                Navigator.pushNamedAndRemoveUntil(
                                    context, 'home', (route) => false);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Senha incorreta.'),
                                  ),
                                );
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Usuário não encontrado.'),
                                ),
                              );
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          primary: Color.fromARGB(255, 1, 7,
                              102), // Azul escuro para o botão de login
                        ),
                        child: Text('Login'),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, 'usuario_form');
                      },
                      style: TextButton.styleFrom(
                        primary: Colors.grey[
                            300], // Texto branco com tom meio cinza para o botão "Cadastre-se"
                      ),
                      child: Text(
                        'Não possui uma conta? Cadastre-se',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
