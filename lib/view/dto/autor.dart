class Autor {
  final dynamic id;
  final String nome;

  Autor({
    this.id,
    required this.nome
    });

  @override
  String toString() {
    return '''
    $id
    $nome
    ''';
  }
}
