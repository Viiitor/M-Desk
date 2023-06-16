class Categoria {
  final dynamic id;
  final String nome;

  Categoria({
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
