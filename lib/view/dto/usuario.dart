class Usuario {
  final dynamic id;
  final String usuario;
  final String email;
  final String senha;

  Usuario(
      {this.id,
      required this.usuario,
      required this.email,
      required this.senha});

  factory Usuario.fromMap(Map<String, dynamic> map) {
    return Usuario(
      id: map['id'],
      usuario: map['usuario'],
      email: map['email'],
      senha: map['senha'],
    );
  }

  @override
  String toString() {
    return '''
    $id
    $usuario
    $email
    $senha
    ''';
  }
}
