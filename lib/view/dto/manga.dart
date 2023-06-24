import 'package:mdesk/view/dto/autor.dart';
import 'package:mdesk/view/dto/categoria.dart';

class Manga{
  final dynamic id;
  final String nome;
  final String descricao;
  final String urlAvatar;
  final Categoria categoria;
  final Autor autor;

  Manga({
    this.id,
    required this.nome,
    required this.descricao,
    required this.urlAvatar,
    required this.categoria,
    required this.autor,
  });

   @override
  bool operator ==(other) =>
      other is Manga && other.nome == nome && other.id == id;

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