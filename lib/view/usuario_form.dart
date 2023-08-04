import 'package:flutter/material.dart';
import 'package:mdesk/database/sqlite/dao/usuario_dao_sqlite.dart';
import 'package:mdesk/view/dto/usuario.dart';

class UsuarioForm extends StatefulWidget {
  const UsuarioForm({Key? key}) : super(key: key);

  @override
  State<UsuarioForm> createState() => _UsuarioFormState();
}

class _UsuarioFormState extends State<UsuarioForm> {
  final formKey = GlobalKey<FormState>();
  dynamic id;
  final _usuarioController = TextEditingController();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    receberDadosParaAlteracao(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro'),
        backgroundColor: Color.fromARGB(255, 1, 7, 102), // Azul escuro marinho
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: Colors.grey[900], // Dark grey para o fundo da página
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 20),
              TextFormField(
                controller: _usuarioController,
                decoration: InputDecoration(
                  labelText: 'Nome',
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
                    return 'Por favor, digite o nome';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
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
                    return 'Por favor, digite o email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
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
              SizedBox(height: 30),
              Center(
                child: SizedBox(
                  width: 300,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      var formState = formKey.currentState;
                      if (formState != null && formState.validate()) {
                        var usuario = preencherDTO();
                        UsuarioDAOSQLite dao = UsuarioDAOSQLite();
                        dao.salvar(usuario);
                        Navigator.pop(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 1, 7,
                          102), // Azul escuro para o botão de cadastro
                    ),
                    child: Text(
                      'Cadastrar-se',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void receberDadosParaAlteracao(BuildContext context) {
    var parametro = ModalRoute.of(context);
    if (parametro != null && parametro.settings.arguments != null) {
      Usuario usuario = parametro.settings.arguments as Usuario;
      id = usuario.id;
      preencherCampos(usuario);
    }
  }

  Usuario preencherDTO() {
    return Usuario(
      id: id,
      usuario: _usuarioController.text,
      email: _emailController.text,
      senha: _senhaController.text,
    );
  }

  void preencherCampos(Usuario usuario) {
    _usuarioController.text = usuario.usuario;
    _emailController.text = usuario.email;
    _senhaController.text = usuario.senha;
  }
}
