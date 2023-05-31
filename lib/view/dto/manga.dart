class Manga{
  final dynamic id;
  final String nome;
  final String descricao;
  final String urlAvatar;

  Manga({
    this.id,
    required this.nome,
    required this.descricao,
    required this.urlAvatar
  });

  @override
  String toString() {
      return '''
      $id
      $nome 
      $descricao
      $urlAvatar
    ''';
  }

}