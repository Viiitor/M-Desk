class Tipo {
  final dynamic id;
  final String nome;

  Tipo({
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
