import 'package:mdesk/view/dto/tipo.dart';

class Autor {
  final dynamic id;
  final String nome;
  final Tipo tipo;

  Autor({
    this.id,
    required this.nome,
    required this.tipo,
    });

  @override
  String toString() {
    return '''
    $id
    $nome
    ''';
  }
}
